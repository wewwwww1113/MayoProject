package com.kh.springProject.store.model.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.springProject.store.model.dao.StoreDao;
import com.kh.springProject.store.model.vo.Cart;
import com.kh.springProject.store.model.vo.Store;

@Service
public class StoreServiceImpl implements StoreService {

    @Autowired
    private StoreDao storeDao;

    @Override
    public List<Store> selectAllStores() {
        return storeDao.selectAllStores();
    }

    @Override
    public Store findByStoreNo(int storeNo) {
        return storeDao.findByStoreNo(storeNo);
    }

    @Override
    public int insertStore(Store store) {
        return storeDao.insertStore(store);
    }

    @Override
    public int updateStore(Store store) {
        return storeDao.updateStore(store);
    }

    @Override
    public int deleteStore(int storeNo) {
        return storeDao.deleteStore(storeNo);
    }
    @Override
    public int addToCart(String memberNo, int storeNo, int quantity) {
        Cart cart = new Cart();
        cart.setMemberNo(memberNo);
        cart.setStoreNo(storeNo);
        cart.setQuantity(quantity);
        return storeDao.insertCart(cart);
       
    }

    @Override
    public List<Cart> getCartItems(String memberNo) {
        return storeDao.selectCartItems(memberNo);
    }
    @Override
    public int deleteCartById(int cartId) throws Exception {
    	return storeDao.deleteCartById(cartId);
    }
    @Override
    public void updateCartQuantity(int cartId, int quantity) {
        storeDao.updateCartQuantity(cartId, quantity);
    }
    
}