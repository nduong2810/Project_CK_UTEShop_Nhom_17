package com.uteshop.utils;

import java.text.Normalizer;

public class VietnameseNormalizer {
    // Normalize Vietnamese text: NFC, remove combining diacritics, fix encoding
    public static String normalize(String input) {
        if (input == null) return null;
        // Unicode normalization (NFC)
        String normalized = Normalizer.normalize(input, Normalizer.Form.NFC);
        // Optionally, remove combining diacritics (if needed)
        // normalized = normalized.replaceAll("\\p{InCombiningDiacriticalMarks}+", "");
        return normalized.trim();
    }
}
