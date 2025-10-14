package com.lgy.project_book_store.dto;

import lombok.Data;

@Data
public class SearchDTO {
    private Integer bookId;
    private String  bookTitle;
    private String  bookWriter;
    private String  bookPub;
    private java.sql.Date  bookDate;     
    private Integer genreId;
    private String  genreName;
    private Integer bookPrice;
    private Integer bookCount;
    private String  bookComm;
    private String  bookIsbn;
    private String  bookImagePath; 
}
