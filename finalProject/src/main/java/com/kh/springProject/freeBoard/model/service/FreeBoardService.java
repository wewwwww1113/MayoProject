package com.kh.springProject.freeBoard.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.freeBoard.model.vo.Category;
import com.kh.springProject.freeBoard.model.vo.fbReply;
import com.kh.springProject.freeBoard.model.vo.freeBoard;

public interface FreeBoardService {

	int listCount();

	ArrayList<freeBoard> selectList(PageInfo pi);

	int insertBoard(freeBoard b);

	int increaseCount(int boardNo);

	freeBoard selectBoard(int boardNo);

	int updateBoard(freeBoard b);

	int deleteBoard(int boardNo);

	ArrayList<fbReply> replyList(int boardNo);

	int insertReply(fbReply r);

	int cListCount(int categoryNo);


	ArrayList<Category> boardInsert();

	ArrayList<freeBoard> orderByCategory(int categoryNo, PageInfo pi);


	List<freeBoard> searchBoard(String type, String searchContent);

	int getSearchCount(String searchOption, String searchContent);





}
