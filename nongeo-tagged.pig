tweets = LOAD 'input/tweets.tsv' USING PigStorage('\t') AS (tweetId,userId,userName:chararray,tweetTime:chararray,text:chararray);
filtered_tweets_by_jobs = FILTER tweets  BY text MATCHES '.*(#vacature|#Vacature).*';
filtered_tweets_by_keyword = FILTER filtered_tweets_by_jobs BY text MATCHES '(?i).*(ontwikkeler|ontwikkelaar|ontwerper|software ontwikkeling|designer|software developer|software architect|software engineer|web developer|software engineer|network|database|netwerkbeheer|netwerk|opensource|java|ux designer|applicatiebeheerder|ETL|informatie analist|business intelligence|scrum|solution architect|cloud|azure|microsoft|linux).*';
sample_tweets = SAMPLE filtered_tweets_by_keyword 0.02;
results = FOREACH sample_tweets GENERATE userName,text,tweetTime;
STORE results INTO 'output/';








