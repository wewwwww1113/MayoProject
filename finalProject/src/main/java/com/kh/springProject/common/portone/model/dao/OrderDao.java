package com.kh.springProject.common.portone.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springProject.common.portone.model.vo.Order;

@Repository
public class OrderDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    public int insertOrder(Order order) {
        return sqlSession.insert("orderMapper.insertOrder", order);
    }

    public Order selectOrder(String mcUid) {
        return sqlSession.selectOne("orderMapper.selectOrder", mcUid);
    }
}