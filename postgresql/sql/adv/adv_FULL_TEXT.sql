
/*
Full Text Search in PostgreSQL
REFS: 
    - https://www.postgresql.org/docs/current/textsearch.html
    - https://www.udemy.com/course/postgresqlmasterclass/learn/lecture/23773890#overview

- Limitation of LIKE Queries for Text Search:
    - There is no linguistic support, even for English. Regular expressions are not sufficient because they cannot easily handle derived words, e.g., satisfies and satisfy. 
    - They provide no ordering (ranking) of search results, which makes them ineffective when thousands of matching documents are found.
    - They tend to be slow because there is no index support, so they must process all documents for every search.

- Full Text Indexing and searching
    - to_tsvector:  Converts a document to a tsvector, which is a sorted list of distinct lexemes (words) with their positions in the document.
    - to_tsquery:   Converts a query string to a tsquery, which is a representation of the search query.
    - @@ operator:  Tests whether a tsvector matches a tsquery.
*/


/* Setting the search path to the appropriate schema */
SET search_path = public;

-- Use LIKE %% for simple pattern matching
SELECT nombre, descripcion

-- Convert to lexemes using to_tsvector
SELECT to_tsvector('washes'), to_tsvector('washing'), to_tsvector('washed');

-- Create a list of tokens from a document using to_tsvector
SELECT to_tsvector('The quick brown fox jumped over the lazy dog') AS document

/*
Operators for Full Text Search:
- @@ : Match operator
- &  : AND operator
- |  : OR operator
- !  : NOT operator
- <-> : FOLLOWED BY operator: 
    - <-> operator requires that the first term is immediately followed by the second term.
    - <2> operator requires that the first term is followed by the second term with exactly one word in between.
    - NOTE: the order of the words matters in <-> operator
*/

-- Search for lexemes using to_tsquery and @@ operator
SELECT to_tsvector('The quick brown fox jumped over the lazy dog')
        @@ to_tsquery('quick & fox') AS query;

-- Not found, returns false
SELECT to_tsvector('The quick brown fox jumped over the lazy dog')
        @@ to_tsquery('foxtrot') AS query;


----------- Sample Data for Full Text Search Demonstrations
/*
    - @pgsql generate some sample data to insert into a table for full text search
    - I'll generate sample data suitable for full text search demonstrations. Let me first check the current database structure to see what tables exist. I'll create a new table specifically designed for full text search demonstrations and populate it with rich sample data. This will be perfect for testing the FTS concepts in your document.
*/

-- Drop the table if it already exists
DROP TABLE IF EXISTS public.articles;

/*
- Create a table for full text search demo: articles/blog posts
- Create a separate tsvector column to hold the output of to_tsvector. 
    - To keep this column automatically up to date with its source data, use a stored generated column.
*/
CREATE TABLE public.articles (
    article_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,
    tags VARCHAR(100),
    published_date DATE NOT NULL,
    content_seached tsvector GENERATED ALWAYS AS (to_tsvector('english', content)) STORED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--Then we create a GIN index to speed up the search:
CREATE INDEX content_seached_idx ON public.articles USING GIN (content_seached);

-- Insert sample data with rich text content for FTS demonstrations
INSERT INTO public.articles (title, author, category, content, tags, published_date) VALUES
(
    'Introduction to PostgreSQL Full Text Search',
    'Maria Garcia',
    'Database',
    'PostgreSQL provides powerful full text search capabilities that go far beyond simple LIKE queries. The tsvector and tsquery data types allow for sophisticated linguistic analysis and ranking. Full text search in PostgreSQL supports stemming, which means searching for "run" will also match "running", "runs", and "ran". This feature makes searching more intuitive and user-friendly. The system can handle multiple languages and provides excellent performance through GIN and GiST indexes.',
    'postgresql, fts, search, database',
    '2024-01-15'
),
(
    'Optimizing Database Performance',
    'John Smith',
    'Performance',
    'Database performance optimization requires careful analysis of query execution plans. Understanding how indexes work is crucial for achieving optimal performance. B-tree indexes are excellent for equality and range queries, while hash indexes work well for simple equality comparisons. GIN indexes excel at full text search and array operations. Regular vacuum operations help maintain database health and prevent bloat. Monitoring query performance with EXPLAIN ANALYZE is essential.',
    'performance, optimization, indexes',
    '2024-01-20'
),
(
    'Building Scalable Web Applications',
    'Sarah Johnson',
    'Development',
    'Modern web applications demand scalability and high availability. Implementing proper caching strategies can dramatically improve response times. Using connection pooling helps manage database connections efficiently. Load balancing distributes traffic across multiple servers. Microservices architecture enables independent scaling of different components. Container orchestration with Kubernetes simplifies deployment and scaling. Monitoring and logging are critical for maintaining system health.',
    'web, scalability, architecture',
    '2024-02-01'
),
(
    'Machine Learning for Beginners',
    'David Chen',
    'AI',
    'Machine learning algorithms learn patterns from data without explicit programming. Supervised learning uses labeled data to train models for classification and regression tasks. Unsupervised learning discovers hidden patterns in unlabeled data through clustering and dimensionality reduction. Neural networks mimic the human brain structure with interconnected layers of neurons. Deep learning uses multiple layers to extract increasingly abstract features. Training models requires careful selection of hyperparameters and validation techniques.',
    'machine-learning, ai, neural-networks',
    '2024-02-10'
),
(
    'Cybersecurity Best Practices',
    'Emily Rodriguez',
    'Security',
    'Protecting systems from cyber threats requires multiple layers of defense. Strong password policies and multi-factor authentication prevent unauthorized access. Regular security audits identify vulnerabilities before attackers exploit them. Encryption protects sensitive data both in transit and at rest. Keeping software updated patches known security holes. Employee training reduces risks from phishing and social engineering attacks. Incident response plans ensure quick recovery from breaches.',
    'security, cybersecurity, protection',
    '2024-02-15'
),
(
    'Cloud Computing Essentials',
    'Michael Brown',
    'Cloud',
    'Cloud computing delivers computing resources over the internet on-demand. Infrastructure as a Service provides virtual machines and networking. Platform as a Service offers development environments and deployment tools. Software as a Service delivers applications through web browsers. Cloud providers offer global availability zones for redundancy. Auto-scaling adjusts resources based on demand automatically. Pay-as-you-go pricing reduces capital expenditure.',
    'cloud, aws, azure, infrastructure',
    '2024-02-20'
),
(
    'Agile Project Management',
    'Lisa Anderson',
    'Management',
    'Agile methodology emphasizes iterative development and continuous feedback. Scrum framework organizes work into short sprints with daily standups. Kanban visualizes workflow and limits work in progress. User stories capture requirements from customer perspective. Sprint retrospectives identify improvements for future iterations. Continuous integration automates testing and deployment. Product backlog prioritizes features based on business value.',
    'agile, scrum, project-management',
    '2024-03-01'
),
(
    'Data Science with Python',
    'Robert Taylor',
    'Data Science',
    'Python has become the dominant language for data science and analytics. Pandas library provides powerful data manipulation capabilities. NumPy enables efficient numerical computations on arrays. Matplotlib and Seaborn create beautiful visualizations. Scikit-learn offers comprehensive machine learning algorithms. Jupyter notebooks facilitate interactive data exploration. Statistical analysis reveals insights hidden in raw data.',
    'python, data-science, analytics',
    '2024-03-05'
),
(
    'Understanding Docker Containers',
    'Jennifer White',
    'DevOps',
    'Docker containers package applications with their dependencies for consistent deployment. Images serve as blueprints for creating containers. Dockerfile defines build instructions for custom images. Docker Compose orchestrates multi-container applications. Volumes persist data beyond container lifecycle. Networks enable communication between containers. Registry repositories store and distribute images.',
    'docker, containers, devops',
    '2024-03-10'
),
(
    'RESTful API Design Principles',
    'Thomas Martinez',
    'Development',
    'REST architecture uses HTTP methods for resource manipulation. GET retrieves resources without side effects. POST creates new resources. PUT updates existing resources completely. PATCH applies partial modifications. DELETE removes resources. Proper status codes communicate operation results. Versioning ensures backward compatibility. Authentication secures API endpoints.',
    'rest, api, web-services',
    '2024-03-15'
),
(
    'Introduction to Blockchain Technology',
    'Amanda Lewis',
    'Blockchain',
    'Blockchain creates immutable distributed ledgers through cryptographic hashing. Blocks contain transaction data linked to previous blocks. Consensus mechanisms validate new blocks without central authority. Proof of work requires computational effort for mining. Smart contracts execute automatically when conditions are met. Decentralization eliminates single points of failure. Cryptocurrency applications demonstrate blockchain potential.',
    'blockchain, cryptocurrency, distributed',
    '2024-03-20'
),
(
    'Mobile App Development Strategies',
    'Christopher Davis',
    'Mobile',
    'Mobile development requires choosing between native and cross-platform approaches. Native apps deliver optimal performance using platform-specific languages. React Native and Flutter enable cross-platform development with shared codebases. Progressive web apps work across devices through browsers. Mobile-first design prioritizes small screen experiences. Push notifications engage users proactively. App store optimization improves discoverability.',
    'mobile, react-native, flutter',
    '2024-03-25'
);

-- Create additional sample data for testing specific FTS scenarios
INSERT INTO public.articles (title, author, category, content, tags, published_date) VALUES
(
    'The Art of Running Marathons',
    'Jessica Runner',
    'Sports',
    'Running marathons requires dedication and proper training. Runners must build endurance gradually. The runner who runs consistently will find that running becomes easier. Many runners run early in the morning. Marathon running tests both physical and mental strength.',
    'running, marathon, fitness',
    '2024-04-01'
),
(
    'Quick Brown Fox Story',
    'Classic Tales',
    'Literature',
    'The quick brown fox jumped over the lazy dog near the riverbank. This quick fox was known throughout the forest for its agility. The lazy dog barely noticed as the fox leaped gracefully overhead.',
    'fox, dog, animals',
    '2024-04-05'
);

SELECT * FROM public.articles;

-- Example Full Text Search Queries using the generated column
-- Basic search for "database"
SELECT title, author
FROM public.articles
WHERE content_seached @@ to_tsquery('english', 'database');

-- Search with stemming (finds "running", "runs", "ran")
SELECT title
FROM public.articles
WHERE content_seached @@ to_tsquery('english', 'run');  

-- AND operator
SELECT title
FROM public.articles
WHERE content_seached @@ to_tsquery('english', 'docker & container');

-- Example Full Text Search Queries NOT using the generated column

-- Basic search for "database"
SELECT title, author
FROM public.articles
WHERE to_tsvector('english', content) @@ to_tsquery('english', 'database');

-- Search with stemming (finds "running", "runs", "ran")
SELECT title
FROM public.articles
WHERE to_tsvector('english', content) @@ to_tsquery('english', 'run');

-- AND operator
SELECT title
FROM public.articles
WHERE to_tsvector('english', content) @@ to_tsquery('english', 'docker & container');

-- OR operator
SELECT title
FROM public.articles
WHERE to_tsvector('english', content) @@ to_tsquery('english', 'python | javascript');
 
-- Phrase search with proximity: NOTE: the order of the words matters in <-> operator
SELECT title
FROM public.articles
WHERE to_tsvector('english', content) @@ to_tsquery('english', 'quick <-> fox');

-- Search with ranking
SELECT title, ts_rank(to_tsvector('english', content), query) AS rank
FROM public.articles, to_tsquery('english', 'machine & learning') query
WHERE to_tsvector('english', content) @@ query
ORDER BY rank DESC;


-------------------------------
/* 
    Presidents speeches
*/

CREATE TABLE speeches   (
    doc_id SERIAL PRIMARY KEY,
    president VARCHAR(100) NOT NULL,
    speech_date DATE NOT NULL,
    speech_text TEXT NOT NULL,
    speech_text_search tsvector
); 