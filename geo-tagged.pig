tweets = LOAD 'input/tweets.tsv' USING PigStorage('\t') AS (tweetId,userId,userName:chararray,text:chararray,latitude,longitude,tweetTime:chararray,month:int);
filtered_tweets_by_username = FILTER tweets BY userName=='Startup jobs' OR userName=='NJ.com Jobs' OR userName=='UNjobs Water' OR userName=='VMware Jobs' OR userName=='bartmichiels' OR userName=='Akkermans & Partners' OR userName=='Brussels DataScience' OR userName=='DutchBasecamp' OR userName=='dasauge® Jobs' OR userName=='JobsDirectUSA.com' OR userName=='Open & Bloot' OR userName=='Jobs in Finland' OR userName=='UNjobs Gender' OR userName=='UNjobs Climate' OR userName=='DataInnovationHub.eu' OR userName=='HSArbeidsvo ORwaarden' OR userName=='NL Jobs' OR userName=='UNjobs Health' OR userName=='AEIDL' OR userName=='180 Amsterdam' OR userName=='UNjobs Food' OR userName=='UNjobs Climate' OR userName=='Jobs Hub' OR userName=='UNjobs Water' OR userName=='Web-alan työpaikat' OR userName=='UNjobs Energy' OR userName=='TMJ-NET ' OR userName=='TMJ-BEL' OR userName=='TMJ-USA' OR userName=='Hilton EMEA' OR userName=='TMJ-MIA ' OR userName=='TMJ-GER	' OR userName=='TMJ-FRA' OR userName=='Jobs at Baker Hughes' OR userName=='Jobs at Equinix' OR userName=='4-freelancers.nl' OR userName=='GitHub Jobs' OR userName=='Jobs at Baker Hughes' OR userName=='Global Jobs' OR userName=='Accenture in BeLux' OR userName=='TMJ-BEL Mgmt. Jobs' OR userName=='TheJobTweets_NL_eCom' OR userName=='Jacksonville jobs' OR userName=='TMJ-NET IT Jobs' OR userName=='UNjobs M&E' OR userName=='Iv ORy Standard' OR userName=='TMJ-BEL Mgmt. Jobs' OR userName=='W ORk at Medpace' OR userName=='TMJ-NET Energy Jobs' OR userName=='TMJ-BEL Govern Jobs' OR userName=='TMJ-NET HR Jobs' OR userName=='TMJ-NET Engin. Jobs' OR userName=='TMJ-NET Cleric. Jobs' OR userName=='TMJ-NET HRTA Jobs' OR userName=='P&G Jobs' OR userName=='TMJ-BEL IT-DB Jobs' OR userName=='TMJ-NET IT PM Jobs' OR userName=='Jobs at  ORacle' OR userName=='TMJ-BEL Govern Jobs' OR userName=='TMJ-BEL Health Jobs' OR userName=='TMJ-NET Sales Jobs' OR userName=='TMJ-NET Jobs' OR userName=='Tenneco Jobs' OR userName=='TMJ-BEL IT-Java Jobs' OR userName=='TMJ-NET Advert. Jobs' OR userName=='TMJ-BEL Jobs' OR userName=='FM Global Careers' OR userName=='Bluedesk CRM' OR userName=='Job Internship UK' OR userName=='The Job Tweets ES' OR userName=='Iv ORy Standard';

filtered_tweets_by_keyword = FILTER filtered_tweets_by_username BY text MATCHES '(?i).*(ontwikkeler|ontwikkelaar|ontwerper|software ontwikkeling|designer|software developer|software architect|software engineer|web developer|software engineer|network|database|netwerkbeheer|netwerk|opensource|java|ux designer|applicatiebeheerder|ETL|informatie analist|business intelligence|scrum|solution architect|cloud|azure|microsoft|linux).*';
results = FOREACH filtered_tweets_by_keyword GENERATE userName,text,latitude,longitude,tweetTime;
STORE results INTO 'itsoftware/';

filtered_tweets_by_keyword = FILTER filtered_tweets_by_username BY text MATCHES '(?i).*(#finance).*';
results = FOREACH filtered_tweets_by_keyword GENERATE userName,text,latitude,longitude,tweetTime;
STORE results INTO 'finance/';

filtered_tweets_by_keyword = FILTER filtered_tweets_by_username BY text MATCHES '(?i).*(#hospitality ).*';
results = FOREACH filtered_tweets_by_keyword GENERATE userName,text,latitude,longitude,tweetTime;
STORE results INTO 'hospitality /';

filtered_tweets_by_keyword = FILTER filtered_tweets_by_username BY text MATCHES '(?i).*(#consulting).*';
results = FOREACH filtered_tweets_by_keyword GENERATE userName,text,latitude,longitude,tweetTime;
STORE results INTO 'consulting/';

filtered_tweets_by_keyword = FILTER filtered_tweets_by_username BY text MATCHES '(?i).*(#marketing).*';
results = FOREACH filtered_tweets_by_keyword GENERATE userName,text,latitude,longitude,tweetTime;
STORE results INTO 'marketing/';

filtered_tweets_by_keyword = FILTER filtered_tweets_by_username BY text MATCHES '(?i).*(#pharmaceutical|healthcare|medical|pharmaceutical).*';
results = FOREACH filtered_tweets_by_keyword GENERATE userName,text,latitude,longitude,tweetTime;
STORE results INTO 'healthcare/';

filtered_tweets_by_keyword = FILTER filtered_tweets_by_username BY text MATCHES '(?i).*(#manufacturing).*';
results = FOREACH filtered_tweets_by_keyword GENERATE userName,text,latitude,longitude,tweetTime;
STORE results INTO 'manufacturing/';

filtered_tweets_by_keyword = FILTER filtered_tweets_by_username BY text MATCHES '(?i).*(#insurance).*';
results = FOREACH filtered_tweets_by_keyword GENERATE userName,text,latitude,longitude,tweetTime;
STORE results INTO 'insurance/';

filtered_tweets_by_keyword = FILTER filtered_tweets_by_username BY text MATCHES '(?i).*(#customerservice).*';
results = FOREACH filtered_tweets_by_keyword GENERATE userName,text,latitude,longitude,tweetTime;
STORE results INTO 'customerservice/';

filtered_tweets_by_keyword = FILTER filtered_tweets_by_username BY text MATCHES '(?i).*(ontwikkeler|ontwikkelaar|ontwerper|software ontwikkeling|designer|software developer|software architect|software engineer|web developer|software engineer|network|database|netwerkbeheer|netwerk|opensource|java|ux designer|applicatiebeheerder|ETL|informatie analist|business intelligence|scrum|solution architect|cloud|azure|microsoft|linux).*';
results = FOREACH filtered_tweets_by_keyword GENERATE userName,text,latitude,longitude,tweetTime;
STORE results INTO 'itsoftware/';

filtered_tweets_by_keyword = FILTER filtered_tweets_by_username BY text MATCHES '(?i).*(#accounting).*';
results = FOREACH filtered_tweets_by_keyword GENERATE userName,text,latitude,longitude,tweetTime;
STORE results INTO 'accounting/';








