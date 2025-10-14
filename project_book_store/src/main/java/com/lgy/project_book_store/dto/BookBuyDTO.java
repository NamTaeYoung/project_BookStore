package com.lgy.project_book_store.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BookBuyDTO {
    private int buy_id;
    private int book_id;
    private String user_id;
    private Date purchase_date;
}
