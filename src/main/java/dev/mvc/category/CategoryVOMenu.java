package dev.mvc.category;

import java.util.ArrayList;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

//CREATE TABLE CATEGORY(
//CATEGORYNO                            NUMBER(10)         NOT NULL         PRIMARY KEY,
//NAME                                  VARCHAR2(30)         NOT NULL,
//NAMESUB                               VARCHAR2(30)         DEFAULT '-'         NOT NULL,
//CNT                                   NUMBER(7)         DEFAULT 0         NOT NULL,
//RDATE                                 DATE         NOT NULL,
//SEQNO                                 NUMBER(5)         DEFAULT 0         NOT NULL,
//VISIBLE                               CHAR(1)         DEFAULT 'N'         NOT NULL
//);

@Setter @Getter
public class CategoryVOMenu {
  /** 중분류명 */
  private String name;
  
  /** 소분류명 */
  ArrayList<CategoryVO> list_namesub;

public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}

public ArrayList<CategoryVO> getList_namesub() {
	return list_namesub;
}

public void setList_namesub(ArrayList<CategoryVO> list_namesub) {
	this.list_namesub = list_namesub;
}
}

