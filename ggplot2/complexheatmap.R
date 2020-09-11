source('Utils.R')

cancer_normal <- rownames_to_column(sample_info, var = 'sample_id') %>%
  filter(group %in% c('Cancer', 'Normal'))
cancer_normal_samples <- cancer_normal$sample_id

top20_de <- select(de_result, Gene_Symbol, one_of(cancer_normal_samples)) %>%
  filter(!is.na(Gene_Symbol)) %>%
  distinct(Gene_Symbol, .keep_all = T) %>% #.keep_all保留所有变量，指定列去重复值
  dplyr::slice(1:20) %>%
  column_to_rownames(var = 'Gene_Symbol')

pheatmap::pheatmap(top20_de) # 必须是一个matrix

 
















