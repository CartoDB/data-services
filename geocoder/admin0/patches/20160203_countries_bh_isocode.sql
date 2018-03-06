-- Patch 0.0.1 data version -20160203

DELETE FROM admin0_synonyms WHERE rank = 8 AND char_length(name_) < 4;
