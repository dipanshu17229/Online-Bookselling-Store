/* 1. PUBLISHER */
	/* 1. To add a book */
    INSERT INTO book (ISBN, genre, A_ID, P_ID, title, lang, publish_year, price, Quantity, b_description)
    VALUES('0118564227658', 'Mystery', '2254','5541','Cupiditate consequatur dolorem ut expedita laboriosam molestiae in.',
    'ENGLISH','2020','250','5000','Odio repellat in ad neque. Corrupti adipisci expedita eaque voluptas natus. Placeat excepturi 
    a praesentium nihil earum. Est nam animi dolores libero quae in optio.');
	
    /* 2. To see number of unsold book */
	select quantity from book where ISBN = "0018564227658";
    
    /* 3. To see number of book sold */
    select r.ISBN,r.sold from ranklist r where exists(select * from book b where b.ISBN = r.ISBN);
    
    /* 4. To see how many books are sold by a particular Publisher */
    select SUM(sold) from ranklist r, book b where b.ISBN = r.ISBN and P_ID = "5541";
	
    /* 5. To see how many books got avg_rating above 7 which are published by a particular Publisher */
    select COUNT(*) from ranklist r, book b where b.ISBN = r.ISBN and r.avg_rating>7 and P_ID = "5055";
	
    -- Select sold from ranklist where ISBN = "0115520178594" or ISBN = "5274891286958";
    
/* 2. AUTHOR */
	/* 1. selecting book to see it's rank */
	select * from ranklist r where exists(select * from book b where b.ISBN = r.ISBN) and ISBN = "0018564227658";
	
    /* 2. selecting books according to author */
	select * from book where A_ID = "2254";
	
    /* 3. get average rating for his book */ /*2280*/
    select avg_rating from ranklist where ISBN = "0018564227658";
    
    /* 4. Get avg_rating and number of sold copies of books written by a particular author in descending order*/
    Select avg_rating, sold from ranklist r, book b where b.ISBN = r.ISBN and A_ID = "2280"
    ORDER BY avg_rating DESC, sold DESC;
    
/* 3. CUSTOMER */
	/* 1. Selecting a book by title */
	select * from book where title = "Cupiditate consequatur dolorem ut expedita laboriosam molestiae in.";
    
    /* 2. Selecting a book by genre */
	select * from book where genre = "Mystery";
	
    /* 3. Displaying books according to rank based on genres */
	select * from ranklist where genre = "Mystery" order by B_Rank ASC ;
	
    /* 4. Read reviews for books */
    select b.ISBN, cust_re from Cust_Review re, book b where b.ISBN = re.ISBN;
    
    /* 5. Get most popular books */
    select b.title,b.ISBN,b.genre,r.sold from ranklist r inner join book b on r.ISBN=b.ISBN order by r.sold desc limit 50;

/* 4. CRITIC */
	/* 1. seeing reviews of books by other critics */
	select * from critic_review c where exists(select * from book b where b.ISBN = c.ISBN);
	
    /* 2. Selecting a book by title */
	select * from book where title = "Cupiditate consequatur dolorem ut expedita laboriosam molestiae in.";
    
    /* 3. Selecting a book by genre */
	select * from book where genre = "Mystery";
    
    
/* to see total number of books available in library */
    select count(ISBN) from book;
/* to see different types of genres */    
    select distinct(genre) from book;
/* to see different genres available and number of books in it */
	-- select distinct(genre),count(distinct(genre)) as count from book;
    Select g.genre as Genre, Count(g.genre) as count from book b, genre g where b.genre = g.genre 
    GROUP BY g.genre;
/* to group all books by genre type */ 
	select * from book order by genre ASC;
/* to display all books having rating higher than x */
	select ISBN,title,genre from book b where ISBN IN (select ISBN from ranklist r where b.ISBN = r.ISBN and avg_rating > 7 ) ; 
    /* OR */
	select b.ISBN,b.title,b.genre,r.B_Rank, r.avg_rating from book b INNER JOIN ranklist r where b.ISBN = r.ISBN AND r.avg_rating > 7; 
	/* OR */
	Select b.ISBN, b.title, b.genre, r.B_rank, r.avg_rating from book b, ranklist r where b.ISBN = r.ISBN and r.avg_rating > 7;
    
    SHOW GRANTS for 'root'@localhost;