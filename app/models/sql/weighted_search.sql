WITH
  searched_words as (
    SELECT
      words.*,
      :searched_groups_count AS searched_groups_count,
      :max_weight AS weight
    FROM words
    WHERE words.id IN (:searched_word_ids)
  ),
  grouped_words as (
    SELECT
      word_id,
      COUNT(*) AS searched_groups_count
    FROM groupings
    WHERE group_id IN (:group_ids) AND word_id NOT IN (:searched_word_ids)
    GROUP BY word_id ORDER BY searched_groups_count DESC LIMIT :max_related_words
  ),
  ranked_words AS (
    SELECT
      *,
      DENSE_RANK() OVER (ORDER BY searched_groups_count ASC) AS dense_rank
    FROM grouped_words
  ),
  statistics as (
    SELECT
      max(dense_rank) AS dense_rank_max
    FROM ranked_words
  ),
  weighted_words as (
    SELECT
      DISTINCT words.*,
      ranked_words.searched_groups_count,
      width_bucket(
        ranked_words.dense_rank,
        0.999,
        statistics.dense_rank_max + 0.001,
        :max_weight
      ) AS weight
    FROM
      ranked_words
    LEFT JOIN words ON words.id = ranked_words.word_id
    LEFT JOIN parts_of_speech ON parts_of_speech.word_id = ranked_words.word_id,
      statistics
    WHERE parts_of_speech.type_code IN (:parts_of_speech_type_code)
  )
(SELECT * FROM searched_words) UNION (SELECT * FROM weighted_words)
ORDER BY name ASC
