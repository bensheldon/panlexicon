function bucketSort(numBuckets, arr, func) {
  func = func || (val => val);

  const arrVals = arr.map(func);

  const result = [];
  const minVal = Math.min(...arrVals);
  const maxVal = Math.max(...arrVals);
  const range = maxVal - minVal;
  const bucketSize = range / numBuckets;

  for (let i = 0; i < numBuckets; i++) {
    const bucketMin = minVal + i * bucketSize;
    const bucketMax = (i + 1) == numBuckets ? maxVal : bucketMin + bucketSize;
    let bucket = [];

    bucket = arr.filter(function(val) {
      const calcVal = func(val);
      return calcVal >= bucketMin && (bucketMax === maxVal ? calcVal <= bucketMax : calcVal < bucketMax);
    });

    result.push(bucket);
  }

  return result;
}

window.addEventListener('load', function (event) {
  const urlParams = new URLSearchParams(window.location.search);
  const hasSearch = urlParams.has("q");
  if (!hasSearch) {
    return
  }

  const searchQuery = urlParams.get("q");
  const resultsEl = document.getElementById('search-results');
  const searchInput = document.getElementById('search');

  if (!hasSearch || searchQuery.length == 0) {
    if (resultsEl) {
      resultsEl.innerHTML = '<p>No search term provided.</p>';
    }
    return
  }

  searchInput.value = searchQuery;

  resultsEl.innerHTML = "<p>Loading...</p>";

  // Split and strip the words
  let searchNames = searchQuery.split(',').map(function (word) {
    return word.trim();
  });

  let wordsData = null;
  let groupsData = null;

  Promise.all([
    fetch(window.jekyllSiteBaseUrl + '/words.json').then(function (response) {
      return response.json();
    }).then(function (wordsJson) {
      wordsData = wordsJson;
    }),
    fetch(window.jekyllSiteBaseUrl + '/groups.json').then(function (response) {
      return response.json();
    }).then(function (groupsJson) {
      groupsData = groupsJson;
    })
  ]).then(() => {
    searchWords = searchNames.map(function (searchName) {
      return wordsData.find(function (wordData) {
        return wordData.name.toLowerCase() === searchName.toLowerCase();
      })
    });

    notfoundIndexes = Array.from(searchWords, (_, i) => i).filter(i => searchWords[i] === undefined);
    if (notfoundIndexes.length > 0) {
      // TODO: show which words were not found
      resultsEl.innerHTML = "<p>One or more search terms not found.</p>";
      return;
    }

    // filter groupsData for groups that contain all searchWords
    let searchGroups = groupsData.filter(function (groupData) {
      return searchWords.every(function (searchWord) {
        return groupData.word_ids.includes(searchWord.id);
      });
    });

    if(searchGroups.length == 0) {
      resultsEl.innerHTML = "<p>No shared meaning found.</p>";
      return;
    }

    // Flatten the searchGroups and count the number of times the word appears across all groups
    const searchWordIdCounts = searchGroups.flatMap(function (groupData) {
      return groupData.word_ids;
    }).reduce(function (wordCounts, wordId) {
      wordCounts[wordId] = (wordCounts[wordId] || 0) + 1;
      return wordCounts;
    }, {})

    const searchWordResults = Object.entries(searchWordIdCounts).sort(function ([wordIdA, wordCountA], [wordIdB, wordCountB]) {
      return wordCountB - wordCountA;
    }).slice(0, 100).map(function ([wordId, wordCount]) {
      wordId = Number(wordId);

      return {
        id: wordId,
        count: wordCount,
        name: wordsData.find(function (wordData) {
          return wordData.id === wordId;
        }).name
      };
    });

    // Ensure searchWords are included in the results
    searchWords.forEach(function (searchWord) {
      const inResults = searchWordResults.find(function (searchWordResult) {
        return searchWordResult.id === searchWord.id;
      });

      if (inResults) {
        inResults.searchWord = true;
      } else {
        searchWordResults.push({
          id: searchWord.id,
          count: searchGroups.length,
          name: searchWord.name,
          searchWord: true
        })
      }
    });

    bucketSort(6, searchWordResults, function (result) {
      return result.count;
    }).forEach(function (bucket, index) {
      bucket.forEach(function (word) {
        word.weight = index + 1;
      })
    });

    searchWordResults.sort(function (a, b) {
      // sort alphabetically
      return a.name.localeCompare(b.name);
    });

    searchWordResults.forEach(function (word) {
      let query = "";

      if (word.searchWord) {
        // omit a searched word from the query
        query = searchWords.filter(function (searchWord) {
          return searchWord.id != word.id;
        }).map(function (searchWord) {
          return searchWord.name;
        }).join(', ');
      } else {
        // add the word to the query
        query = ([].concat(searchWords, word)).map(function (word) {
          return word.name;
        }).join(', ');
      }

      word.link = `${window.jekyllSiteBaseUrl}/?q=${encodeURIComponent(query)}`;
    });

    const output = `
      <ul class="search-results">
        ${searchWordResults.map(function (result) {
          return `
            <li class="word weight-${result.weight}" data-count="${result.count}">
              <a href="${result.link}" ${result.searchWord ? 'class="active"' : ''}>${result.name}</a>
            </li>
          `
        }).join('')}
      </ul>
      `

    resultsEl.innerHTML = output;
  });
});
