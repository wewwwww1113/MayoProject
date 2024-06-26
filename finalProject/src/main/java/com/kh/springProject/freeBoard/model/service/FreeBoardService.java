package com.kh.springProject.freeBoard.model.service;

import java.util.ArrayList;

import com.kh.springProject.common.model.vo.PageInfo;
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

	ArrayList<freeBoard> selectTopList();



}
