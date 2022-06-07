---
title: Tidyverse Command2
tags: tidyverse
categories: R
---

2、进阶命令

| 命令                     | 功能  |
| ---------------------- | --- |
| contains               |     |
| starts_with, ends_with |     |
| matches                |     |
| str_detect             |     |
| strsplit               |     |
| case_when              |     |
| slice_max, min         |     |
|                        |     |

- 创建一个数据集

```R
library('tibble')
library('stringr')
score=tibble(ID=c("1222-1","2001-0","3321-1","4898-0","2782-0","1002-8","4211-0","1023-1","3325-1"),
             gender=c('female',"male","male","male","female","female","male","female","male"),
             chinese_mid_score=round(runif(9,80,90),digits = 0),
             chinese_final_score=round(runif(9,80,90),digits = 0),
             english_score=c(round(runif(8,80,90),digits = 0),NA),
             math_score=round(runif(9,80,90),digits = 0),
             music_score=round(runif(9,80,90),digits = 0))
view(score)
```

- contains, starts_with, ends_with, match特定列的选择

```R
#contains:quickly select columns which contain certain pattern
#"chinese","english"
score_column1=score %>%
  select(contains("chinese")|contains("english"))
names(score_column1)

score_column2=score %>% 
  select(ends_with('score'))
names(score_column2)

#matches:a more flxible approach
score_column=score %>% 
  select(matches('mid'))
```

- str_detect行

```R
#quickly select rows which contain certain pattern
#str_detect(ID,'-1')
#str_detect(score$ID,'-1')
score_pattern=score %>% 
  subset(str_detect(ID,'-1')==TRUE)# false
```

- strsplit

```R
score_substring=score %>% 
  rowwise() %>% #去除这一行试试看什么结果
  mutate(subID=strisplit(ID,'-')) %>% 
  mutate(grade=case_when(
  subID1>=4000~'forth',
  subID1>=3000~'third',
  subID1>=2000~'second',
  subID1>=1000~'first'
)) %>% 
  mutate(status=case_when(
    subID2=='1'~'active',
    subID2=='2'~'inactive',
    subID2=='8'~'unknown'
  ))

#另外取代下半部分可以用
  mutate(status=case_when(
    str_detect(ID,'-1')~'active',
    str_detect(ID,'-0')~'inactive',
    str_detect(ID,'-8')~'unknown'
```

- slice_max

```R
slice_max(english_score,n=1)
```
