package com.kh.springProject.common.template;

import com.kh.springProject.common.model.vo.PageInfo;

public class Pagination {
	// 페이징 처리하기 위한 메소드(재사용성)
	public static PageInfo getPageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {

		int maxPage = (int) Math.ceil((double) listCount / boardLimit);
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;

		if (endPage > maxPage) {
			endPage = maxPage;
		}

		// 처리된 데이터 객체에 담아주기
		PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);

		return pi;// 페이징 정보 반환
	}

}
