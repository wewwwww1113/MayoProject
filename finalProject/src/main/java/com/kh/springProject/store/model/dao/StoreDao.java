package com.kh.springProject.store.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springProject.store.model.vo.Cart;
import com.kh.springProject.store.model.vo.Store;

@Repository
public class StoreDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    public List<Store> selectAllStores() {
        return sqlSession.selectList("storeMapper.selectAllStores");
    }

    public Store findByStoreNo(int storeNo) {
        return sqlSession.selectOne("storeMapper.findByStoreNo", storeNo);
    }

    public int insertStore(Store store) {
        return sqlSession.insert("storeMapper.insertStore", store);
    }

    public int updateStore(Store store) {
        return sqlSession.update("storeMapper.updateStore", store);
    }

    public int deleteStore(int storeNo) {
        return sqlSession.delete("storeMapper.deleteStore", storeNo);
    }
    public int insertCart(Cart cart) {
        return sqlSession.insert("storeMapper.insertCart", cart);
    }
    public List<Cart> selectCartItems(String memberNo) {
        return sqlSession.selectList("storeMapper.selectCartByMember", memberNo);
    }
    public int deleteCartById(int cartId) {
        return sqlSession.delete("storeMapper.deleteCart", cartId);
    }
    public void updateCartQuantity(int cartId, int quantity) {
        Cart cart = new Cart();
        cart.setCartId(cartId);
        cart.setQuantity(quantity);
        sqlSession.update("storeMapper.updateCartQuantity", cart);
    }
    
    
}