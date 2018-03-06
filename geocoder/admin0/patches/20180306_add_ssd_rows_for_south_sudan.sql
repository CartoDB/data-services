insert into admin0_synonyms (name, rank, adm0_a3, name_) select name, rank, 'SSD' as adm0_a3, name_ from admin0_synonyms where adm0_a3 = 'SDS';
