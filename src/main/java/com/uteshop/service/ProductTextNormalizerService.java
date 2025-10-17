package com.uteshop.service;

import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.SanPham;
import com.uteshop.utils.VietnameseNormalizer;
import java.util.List;

public class ProductTextNormalizerService {
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();

    public void normalizeAllProductTextFields() {
        List<SanPham> products = sanPhamDAO.getAllProducts();
        int updatedCount = 0;
        for (SanPham sp : products) {
            String normalizedTenSP = VietnameseNormalizer.normalize(sp.getTenSP());
            String normalizedMoTa = VietnameseNormalizer.normalize(sp.getMoTa());
            String normalizedHinhAnh = VietnameseNormalizer.normalize(sp.getHinhAnh());
            boolean changed = false;
            if (!normalizedTenSP.equals(sp.getTenSP())) {
                sp.setTenSP(normalizedTenSP);
                changed = true;
            }
            if (!normalizedMoTa.equals(sp.getMoTa())) {
                sp.setMoTa(normalizedMoTa);
                changed = true;
            }
            if (!normalizedHinhAnh.equals(sp.getHinhAnh())) {
                sp.setHinhAnh(normalizedHinhAnh);
                changed = true;
            }
            if (changed) {
                sanPhamDAO.updateSanPhamTextFields(sp);
                updatedCount++;
            }
        }
        System.out.println("Đã chuẩn hóa và cập nhật " + updatedCount + " sản phẩm.");
    }
}
