---
title: Tidyverse Command
tags: tidyverse
categories: R
---

#### 1、基本命令

| 命令                | 功能                           |
| ----------------- | ---------------------------- |
| mutate/add_column | create a new columm          |
| rename            | change variable name         |
| filter/subset     | extract certain rows         |
| select            | select columns               |
| group_by          | group observations by column |
| arrange           | sort                         |
| summarise         | calculate summary statistics |
| recode            | recode variable values       |
| if_else           | recode by if conditions      |
| distinct          | remove duplicates            |
|                   |                              |

- mutate

```r
iris1=iris1 %>% mutate(id=c(1:150))
```

- rename

```r
iris1=iris %>% 
  rename(sp=Species)
head(iris1)
```

- filter/subset

```r
# only keep rows which satisfies Sepal.Length<=5 and Sepal.Width=2.5(subset)
iris2=iris %>% 
  subset(Sepal.Length<=5 & Sepal.Width<=2.5)
dim(iris2)
iris2

# only keep rows which satisfies Sepal.Length<=5 and Sepal.Width=2.5(filter)
iris3=iris %>% 
  filter(Sepal.Length<=5 , Sepal.Width<=2.5)
dim(iris3)
iris3
# only keep rows which satisfies Sepal.Length<=5 or Sepal.Width=2.5(subset,filter)
iris4=iris %>% 
  subset(Sepal.Length<=5 | Sepal.Width<=2.5)
dim(iris4)
```

- select

```r
# only keep two columns
iris5=iris %>% 
  select(Sepal.Length,Sepal.Width)
dim(iris5)
# not keep species
iris6=iris %>% 
  select(-Species)
dim(iris6)
```

- group_by

```r
# group by:calculate mean of Petal.Length and Sepal.Width for each category
iris1= iris %>% 
  group_by(Species) %>% 
  summarise(pl_mean=mean(Petal.Length),sw_mean=mean(Sepal.Width))
iris1
```

```r
iris2=iris %>% 
  group_by(Species) %>% 
  mutate(pl_mean=mean(Petal.Length),sw_mean=mean(Sepal.Width)) %>% 
  ungroup()
```

- arrange

```R
#arrange: sort by Sepal.Length(ascending),and Sepal.Width(descending)
iris3=iris %>% 
  arrange(Sepal.Length,desc(Sepal.Width))
head(iris3,10)
```

- recode

```r
#recode:setosa=1,versicolor=2,virginica=3
iris4=iris %>% 
  mutate(Species.new=recode(Species,setosa=1,versicolor=2,virginica=3))
head(iris4)
tail(iris4)
table(iris4$Species)
table(iris4$Species.new)
```

- if_else：

```r
#if_else: make a categorical variable: if Petal.Length>1.4 then "long",else "short"
iris5=iris %>% 
  mutate(pl_cat=if_else(Petal.Length>1.4,'long','short'))
head(iris5)
# 解决上一个recode的另一个方法
mutate(Species.new=if_else(Species="setosa",1,if_else(Species='versicolor',2,3)))
```

- distinct 

```r
#remove duplicates
iris6=iris %>% 
  distinct(Species,.keep_all = TRUE)#remove duplicates in terms of one var
# distinct(Petal.Length,Petal.Width,.keep_all=TRUE) TWO var
iris6
```
