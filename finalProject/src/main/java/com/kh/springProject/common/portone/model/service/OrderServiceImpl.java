package com.kh.springProject.common.portone.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.springProject.common.portone.model.dao.OrderDao;
import com.kh.springProject.common.portone.model.vo.Order;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderDao orderDao;

    @Override
    @Transactional
    public int insertOrder(Order order) {
        return orderDao.insertOrder(order);
    }

    @Override
    public Order getOrder(String mcUid) {
        return orderDao.selectOrder(mcUid);
    }
}