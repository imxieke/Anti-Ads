- https://adguard-dns.io/kb/zh-CN/general/dns-filtering-syntax/
- https://adblockplus.org/filter-cheatsheet#blocking

## 基本语法
- `!` 注释
- `@@` 例外 第二优先级
- `@@@@` 例外 最高优先级
- `*` 通配符 匹配任意数量字符
- `$` 似乎是开头
- `$script` 阻止脚本
- `$3p` 阻止第三方
- `$third-party` 阻止第三方请求
- `domain=domain.com` 当对应该域名则生效1 与上面三个配合
- `^` 分隔符 会匹配下面的
  -  `^abc.com^` 仅屏蔽 `abc.com` 但不会阻止 `abc.com.cn`
  -  `abc.abc.com`
  -  `abc.abc.com:8080`
- `@@||domain.com^` 解除限制
- `|` 指向地址开头或结尾的指针
- `||` 匹配地址的开头。使用此字符，您不必在地址掩码中指定特定的协议和子域。它的意思是，||代表http://*., https://*., ws://*.,wss://*.一次。
- ^ 分隔字符标记。分隔符可以是任何字符，但可以是字母、数字或以下之一·：_ - . %·。在此示例中，分隔符以粗体显示：。地址的末尾也被接受为分隔符。http://example.com/?t=1&t2=t3
- `! Homepage: http://example.com` - 此评论确定应将哪个网页链接为过滤器列表主页。
- `! Title: FooList` - 此注释为过滤器列表设置固定标题。如果存在此评论，则用户无法再更改标题。
- `! Expires: 5 days` - 此注释设置过滤器列表的更新间隔。该值可以以天（例如 5 天）或小时（例如 8 小时）为单位给出。1 小时到 14 天之间的任何值都是可能的。请注意，更新不一定会在此时间间隔之后发生。实际更新时间是随机的，取决于一些额外的因素来减少服务器负载。
- `! Redirect: http://example.com/list.txt` - 此注释表示过滤器列表已移至新的下载地址。Adblock Plus 会忽略该注释之外的任何文件内容并立即尝试从新地址下载。如果成功，过滤器列表的地址将在设置中更新。如果新地址与当前地址相同，则忽略此注释，这意味着它可用于强制执行过滤器列表的“规范”地址。
- `! Version: 1234` - 此注释定义了过滤器列表的数字版本。此版本号显示在问题报告中，可用于验证报告是否引用过滤器列表的当前版本。
- `! Checksum: XXXXX`
- `$3p`是””third-party”的简写，有时候我们只希望我们的拦截规则只对站外的资源生效
- 如访问 example.com 该域名不生效，但该域名其他地址资源会生效

#### 过滤所有 `banner*.gif` 结尾的动图 如 `banner123.gif banner456.gif`
- http://example.com/ads/banner*.gif

#### 例外
- `@@` 具有较高优先级 `@@@@` 具有最高优先级
- `@@` $document option 屏蔽了某些内容
- @@||example.com^$document 解除屏蔽

- `||example.com/banner.gif`
- 匹配 `http://example.com/banner.gif`
- 匹配 `https://example.com/banner.gif`
- 匹配 `http://www.example.com/banner.gif`
- 匹配 `https://www.example.com/banner.gif`

## 通配符子域名
- domain.com
- .domain.com
- *.domain.com

- ad.*.domain.com
- s*.domain.com (屏蔽 `s1.domain.com` `s2.domain.com` `s3.domain.com`)


## 增加域名作用域
- /path/of/banner.js@my.example.com

### 多个作用域
- @example.com,myspace.com

## 性能建议

请优先使用不含通配符的规则，单纯的域名、路径、查询参数或则它们的组合匹配速度非常快，无需遍历查找，几十万的规则条数也不会影响其性能。

带有通配符的规则，其内部我们会转换为正则表达式的贪婪模式，众所周知，正则表达式的贪婪模式性能会比较低一些。所以尽可能优先使用不含通配符的域名、路径、查询参数的组合来撰写规则。

举例说明, 优化后的规则会有更好的额性能。

```
*/path/of/banner.js
example.com/ads/*
?frm=ch&ct=bj&dit=*
```
建议改为

```
/path/of/banner.js
example.com/ads/
?frm=ch&ct=bj&dit=
```

强烈建议在撰写隐藏元素规则的时候加上域名作用域的限定，不仅仅是为了防止误杀，更重要的是有了域名限定性能会更好，规则只在可以匹配的域名下才会执行，这样可以避免无谓的性能消耗。

在撰写隐藏元素规则的时候，我们应该优先使用ID和类选择器，ID选择器的性能最好，可以快速定位页面元素。 下面是理论上选择器按照性能高低排列，使用选择器的时候请优先使用性能高的选择器。

```
id选择器（#myid）
类选择器（.myclassname）
标签选择器（div,h1,p）
相邻选择器（h1+p）
子选择器（ul > li）
后代选择器（li a）
通配符选择器（*）
属性选择器（a[rel=”external”]）
伪类选择器（a:hover,li:nth-child）
```

# 隐藏元素规则
- `##` 匹配元素进行隐藏 + CSS选择器语法

### 隐藏页面中元素ID为 “ad-banner” 的元素
- `###ad-banner`

### 隐藏页面中所有，目标地址为https://www.example.com 的链接

- `##a[href="https://www.example.com"]`


### 隐藏所有类名为”ad-container”的页面元素
- `##.ad-container`


### 隐藏所有页面中存在属性”title”且属性值中包含字符串”ad”的DIV元素
- `##div[title*="ad"]`


## 例外规则
- `@@www.example.com/path/of/advanced/`

- 例如规则会误伤最后一个
`/path/of/ad*`

```
https://www.example.com/path/of/ad/banner.js
https://www.example.com/path/of/ad-show.js
https://www.example.com/path/of/advanced/
```

## 隐藏元素例外规则
- `@#` 作为隐藏元素例外规则的标识，后面紧跟普通的隐藏元素规则
- `@#div[title*="ad"]@example.com`
- `example.com#@#div[title*="ad"]` ABP 规则