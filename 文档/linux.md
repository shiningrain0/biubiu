



# linux

## 配置信息

### 1、网络配置

```sh
vi /etc/sysconfig/network-scriptr/ifcfg-ens33
```

![img](../%E5%9B%BE%E7%89%87/20181109103926967.jpg)

在修改网络配置后需要重启网络

```shell
service network restart
```

能够ping通自己的ip则证明网络配置成功

```shell
ping 192.168.137.110
```

### 2、关闭防火墙

查看防火墙状态

```shell
systemctl status firewalld.service
```

关闭防火墙

```shell
systemctl stop firewalld.service
```

永久关闭防火墙

```shell
systemctl disable firewalld.service
```

### 3、设置主机名

​	需要修改瞬态主机名以及静态主机名，需要注意的是linux对大小写敏感，需要注意规范书写

修改瞬态主机名：

```shell
vi /etc/sysconfig/network
```

追加内容

```shell
NETWORKING=yes
HOSTNAME=master     #此处为你想设置的主机名
```

修改静态主机名

```shell
vi /etc/hostname
```

将原内容全部删除 加上自己的主机名

```shell
master
```

### 4、hosts设置

```shell
vi /etc/hosts
#在文本后追加
192.168.137.110  master
```

5、免密钥登录配置

```shell
ssh-keygen -t rsa
```

四下回车，然后进入ssh文件夹

```shell
cd ~/.ssh
```

查看文件内容

```shell
[root@master ~]# cd ~/.ssh
[root@master .ssh]# ls -l
total 8
-rw-------. 1 root root 1675 Nov 26 17:34 id_rsa   #密钥
-rw-r--r--. 1 root root  393 Nov 26 17:34 id_rsa.pub  #公钥

```

将公钥文件发送给自己

```shell
ssh-copy-id -i id_rsa.pub root@master
```

验证是否成功（若不需要输入密码则代表成功）

```shell
ssh master
```

## 命令

### 查看命令及档案格式

```shell
man ls
info cd
#使用man、info查询不知道含义的指令或者档案格式
```

​	而如果想要架设一些其他的服务，或想要利用一整组软体来达成某项功能时，可到/usr/share/doc 底下查一查有没有该服务的说明档.

| 按键        | 进行工作                                         |
| ----------- | ------------------------------------------------ |
| 空白键      | 向下翻一页                                       |
| [Page Down] | 向下翻一页                                       |
| [Page Up]   | 向上翻一页                                       |
| [tab]       | 在node 之间移动，有node 的地方，通常会以* 显示。 |
| [Enter]     | 当游标在node 上面时，按下Enter 可以进入该node 。 |
| b           | 移动游标到该info 画面当中的第一个node 处         |
| e           | 移动游标到该info 画面当中的最后一个node 处       |
| n           | 前往下一个node 处                                |
| p           | 前往上一个node 处                                |
| u           | 向上移动一层                                     |
| s(/)        | 在info page 当中进行搜寻                         |
| h, ?        | 显示求助选单                                     |
| q           | 结束这次的info page                              |

### 关机操作

```shell
#在进行关机操作前应先运行sync命令（将内存中的数据存到磁盘中）
[root@master opt]# sync
#现在关机
shutdown -h now
#在22：23关机
shutdown -h 22:23
#十分钟后关机
shutdown -h +10
#系统立刻重新开机
shutdown -r now
#20分钟后关机，并进行提示
shutdown -h +20 'the system will be shut down after 20 minuites'
#仅发出警告参数(同时会报无法解析时间范围：Failed to parse time specification)
shutdown -k "this system will be shutdown"
```

### 切换终端

​	当使用文字模式进入linux时，有6个终端（tty1~tty6）可以使用，切换命令为Ctrl+Alt+F1~F6

​	在man 的时候， man page 显示的内容中，指令(或档案)后面会接一组数字，这个数字若为 1, 5, 8 ，表示该查询的指令(或档案)意义为何？

```shell
1： 一般使用者可以使用的指令或可执行档案 5：一些设定档的档案内容格式 8：系统管理员能够使用的管理指令。
```

### 文件操作

| 元件 | 内容         | 叠代物件   | r            | w            | x                     |
| ---- | ------------ | ---------- | ------------ | ------------ | --------------------- |
| 档案 | 详细资料data | 文件资料夹 | 读到文件内容 | 修改文件内容 | 执行文件内容          |
| 目录 | 档名         | 可分类抽屉 | 读到档名     | 修改档名     | 进入该目录的权限(key) |

#### 文件的权限

![image-20201127102508367](../%E5%9B%BE%E7%89%87/image-20201127102508367.png)

![image-20201127103420456](../%E5%9B%BE%E7%89%87/image-20201127103420456.png)

示例：

dr-xr-xr-x. 17 root root  224 Nov 26 16:33 ..

为一个文件夹、文件权限为555，连接数量为17，所有者和所属群组为root,文件容量为244(**预设单位为****bytes**),最近的修改时间为11月26日16：33

```shell
. ：代表当前的目录，也可以使用./ 来表示；
.. ：代表上一层目录，也可以../ 来代表。
如果文档名前面多了一个.则代表这个档案为隐藏文档
Linux档名的限制为：单一档案或目录的最大容许档名为255 个英文字元或128 个中文字元；
```



#### 更改文件权限

```shell
chmod [-R] 权限值 文件名
#-R（注意是大写）选项表示连同子目录中的所有文件，也都修改设定的权限
```

示例

```shell
[root@master opt]# vi hell.txt
[root@master opt]# ll
total 4
-rw-r--r--. 1 root root 29 Nov 27 10:49 hell.txt
[root@master opt]# chmod  777 hell.txt
[root@master opt]# ll
total 4
-rwxrwxrwx. 1 root root 29 Nov 27 10:49 hell.txt
```

![image-20201127110009119](../%E5%9B%BE%E7%89%87/image-20201127110009119.png)

示例：

```shell
[root@master opt]# chmod u=rxw,go=rx hell.txt
[root@master opt]# ll
total 4
-rwxr-xr-x. 1 root root 29 Nov 27 10:49 hell.txt
```

#### 更改文件拥有者

```shell
chown [-R]帐号名称:群组名称档案或目录
#-R : 进行递回(recursive)的持续变更，亦即连同次目录下的所有档案都变更
```

示例

```shell
[root@master opt]# chown bin hell.txt
[root@master opt]# ll
total 4
-rwxr-xr-x. 1 bin root 29 Nov 27 10:49 hell.txt
```

更改文件所属群组

```shell
chgrp [-R] dirname/filename 
#-R : 进行递回(recursive)的持续变更，亦即连同次目录下的所有档案、目录都更新成为这个群组之意。常常用在变更某一目录内所有的档案之情况。
```

示例：

```shell
[root@master opt]# chgrp users hell.txt
[root@master opt]# ll
total 4
-rwxr-xr-x. 1 bin users 29 Nov 27 10:49 hell.txt
```

将文件拥有者与所属群组改回root

```shell
[root@master opt]# chown root:root hell.txt
[root@master opt]# ll
total 4
-rwxr-xr-x. 1 root root 29 Nov 27 10:49 hell.txt
```

复制文件

```shell
cp 来源文档 目标文档
```

示例:

​	此操作是在来源文档的路径下进行的，可不写来源文档路径，但若不在来源文档路径下，需写出来源文档的路径

```shell
[root@master opt]# cp hell.txt /etc/hell.txt
[root@master opt]# cat /etc/hell.txt
hello word!
welocme to linux
```

#### 创建文件夹

创建单级空文件夹

```shell
mkdir 名称
#示例：
mkdir test
```

创建多级文件夹

```shell
mkdir -p 名称/名称/名称/...
#示例：
mkdir -p test1/test2/test3
```

#### 删除文件操作

删除单个文件夹

```shell
rmdir 名称
#示例：
rmdir test
```

删除多级文件夹

```shell
rmdir 名称/名称/名称/...
#示例：
rmdir test1/test2/test3
```

#### 移除文档或目录

```shell
rm 文档或目录
可选参数：
-f ：就是force 的意思，忽略不存在的档案，不会出现警告讯息；
-i ：互动模式，在删除前会询问使用者是否动作
-r ：递回删除啊！最常用在目录的删除了！
```

```shell
#删除文档
rm test1.txt
#删除文件夹
rm -r test
```

查看文档内容

```shell
#从第一行开始显示文件内容（顺序）
[root@master opt]# cat hell.txt
hello word!
welocme to linux
#从最后一行开始显示文件内容（倒序）
[root@master opt]# tac hell.txt
welocme to linux
hello word!
#查看内容并输出行号
[root@master opt]# nl hell.txt
     1	hello word!
     2	welocme to linux
[root@master opt]# cat -n hell.txt
     1	hello word!
     2	welocme to linux
#一页一页的显示内容
more hello.txt
#一页一页的显示内容并且能够向前翻页
less hello.txt
#只看头几行
head -行数 文档名称
head -2 hello.txt
#只看尾几行
tail -行数 文档名称
tail -1 hell.txt
#以二进制的方式读取文档内容
od hell.txt
#取文档的指定范围行
示例： 20-30行
head -30 sdf.conf | tail -n
#取文档的指定范围行并显示正确的行号
cat -n sdf.conf |head -n 20|tail -n 10
#找到某个单词或字母或句子的ASCII对照
echo hello | od -t oCc
[root@master etc]# echo hello |od -t oCc
0000000 150 145 154 154 157 012
          h   e   l   l   o  \n
0000006
```

#### 设置文档隐藏属性

```shell
chattr [+-=][ASacdistu]档案或目录名称
选项与参数：
+ ：增加某一个特殊参数，其他原本存在参数则不动。
- ：移除某一个特殊参数，其他原本存在参数则不动。
= ：设定一定，且仅有后面接的参数

A ：当设定了A 这个属性时，若你有存取此档案(或目录)时，他的存取时间atime 将不会被修改，
     可避免I/O 较慢的机器过度的存取磁碟。(目前建议使用档案系统挂载参数处理这个项目)
S ：一般档案是非同步写入磁碟的(原理请参考前一章sync的说明)，如果加上S这个属性时，
     当你进行任何档案的修改，该更动会『同步』写入磁碟中。
a ：当设定a 之后，这个档案将只能增加资料，而不能删除也不能修改资料，只有root 才能设定这属性
c ：这个属性设定之后，将会自动的将此档案『压缩』，在读取的时候将会自动解压缩，
     但是在储存的时候，将会先进行压缩后再储存(看来对于大档案似乎蛮有用的！)
d ：当dump程序被执行的时候，设定d属性将可使该档案(或目录)不会被dump 备份
i ：这个i 可就很厉害了！他可以让一个档案『不能被删除、改名、设定连结也无法写入或新增资料！』
     对于系统安全性有相当大的助益！只有root 能设定此属性
s ：当档案设定了s 属性时，如果这个档案被删除，他将会被完全的移除出这个硬碟空间，
     所以如果误删了，完全无法救回来了喔！
u ：与s 相反的，当使用u 来设定档案时，如果该档案被删除了，则资料内容其实还存在磁碟中，
     可以使用来救援该档案喔！
注意1：属性设定常见的是a 与i 的设定值，而且很多设定值必须要身为root 才能设定
注意2：xfs 档案系统仅支援AadiS 而已
```

```shell
#建立空文件夹
touch test
#赋予i属性后进行重命名操作
[root@master opt]# chattr +i test
[root@master opt]# mv test test2
mv: cannot move ‘test’ to ‘test2’: Operation not permitted
#去除i属性后进行重命名
[root@master opt]# chattr -i test
[root@master opt]# mv test test1
[root@master opt]# ls
hell.txt  test1
```

查看文件类型：

file  文件

```shell
[root@master opt]# file test1
test1: empty
[root@master opt]# file hell.txt
hell.txt: ASCII text
```

#### 指定档名的搜索

```shell
[root@master opt]# which ifconfig
/usr/sbin/ifconfig
#可加参数 -a 可将所有由PATH目录中可以找到的指令均列出，而不止第一个被找到的指定命令
[root@master opt]# which -a .conf
/usr/bin/which: no .conf in (/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin)
```

#### 档案档名的搜索

```shell
[root@master opt]# whereis ifconfig
ifconfig: /usr/sbin/ifconfig /usr/share/man/man8/ifconfig.8.gz
[root@master opt]# whereis passwd
passwd: /usr/bin/passwd /etc/passwd /usr/share/man/man1/passwd.1.gz
```

whereis的查询速度比find快，因为whereis只查询特定的目录，而非全系统查询

find

find [PATH] [option] [action]

```shell
选项与参数：
1. 与时间有关的选项：共有-atime, -ctime 与-mtime ，以-mtime 说明
   -mtime n ：n 为数字，意义为在n 天之前的『一天之内』被更动过内容的档案；
   -mtime +n ：列出在n 天之前(不含n 天本身)被更动过内容的档案档名；
   -mtime -n ：列出在n 天之内(含n 天本身)被更动过内容的档案档名。
   -newer file ：file 为一个存在的档案，列出比file 还要新的档案档名
```

示例：

将过去系统24小时内有变动过内容的档案列出

```shell
find / -mtime 0
```

#### 压缩文件

将文档/文件进行压缩(gzip/bzip2/xz)

bzip2的压缩率要高于gzip，但在压缩大文件时，bzip2所需时间要高于gzip,xz的压缩率最高但所耗时间长

```shell
#使用gzip进行压缩
gzip 文件/文档名
-v ：可以显示出原档案/压缩档案的压缩比等信息
[root@master opt]# gzip -v test1
test1:	gzip: test1: Operation not permitted
  0.0% -- replaced with test1.gz
[root@master opt]# ls
hell.txt  test1  test1.gz
#在对文档进行压缩时，会直接覆盖原文档
[root@master opt]# gzip -v hell.txt 
hell.txt:	 -6.9% -- replaced with hell.txt.gz
[root@master opt]# ls
hell.txt.gz  test1  test1.gz
#使用bzip2进行压缩
[root@master opt]# bzip2 -v hell.txt 
  hell.txt:  0.446:1, 17.931 bits/byte, -124.14% saved, 29 in, 65 out.
[root@master opt]# ls
hell.txt.bz2  test1
```

读取压缩后的文档内容

```shell
#使用gzip
gcat 压缩文档名称
[root@master opt]# zcat hell.txt.gz 
hello word!
welocme to linux
#使用bzip2
bzcat 压缩文档名称
[root@master opt]# bzcat hell.txt.bz2 
hello word!
welocme to linux
```

查找压缩文档内的内容

```shell
#使用gzip
gcat '内容' 压缩文档名称
[root@master opt]# zgrep 'hell' hell.txt.gz 
hello word!
#查找内容并显示行号
[root@master opt]# zgrep -n 'o' hell.txt.gz 
1:hello word!
2:welocme to linux
#使用bzip2
[root@master opt]# bzgrep 'h' hell.txt.bz2 
hello word!
[root@master opt]# bzgrep -n 'e' hell.txt.bz2 
1:hello word!
2:welocme to linux
```

解压缩已压缩的文档

```shell
gzip -d 压缩文件名称
[root@master opt]# gzip -d hell.txt.gz 
[root@master opt]# ls
hell.txt  test1 

```

### 打包指令

-z : 使用 gzip 来压缩和解压文件

-v : --verbose 详细的列出处理的文件

-f : --file=ARCHIVE 使用档案文件或设备，这个选项通常是必选的

-c : --create 创建一个新的归档（压缩包）

-x : 从压缩包中解出文件

```shell
#压缩
tar -zcvf 压缩后的压缩名  目标压缩文件名
[root@master opt]# tar -zcvf test1.gz hell.txt 
hell.txt
[root@master opt]# ls
hell.txt  test1  test1.gz
#解压缩
tar -zxvf 压缩文件名
[root@master opt]# tar -zxvf test1.gz 
hell.txt
[root@master opt]# ls
hell.txt  test1  test1.gz
```



### 目录存放

| 目录                               | 应放置档案内容                                               |
| ---------------------------------- | ------------------------------------------------------------ |
| 第一部份：FHS 要求必须要存在的目录 |                                                              |
| /bin                               | 系统有很多放置执行档的目录，但/bin比较特殊。因为/bin放置的是在单人维护模式下还能够被操作的指令。 在/bin底下的指令可以被root与一般帐号所使用，主要有：cat, chmod, chown, date, mv, mkdir, cp, bash等等常用的指令。 |
| /boot                              | 这个目录主要在放置开机会使用到的档案，包括Linux核心档案以及开机选单与开机所需设定档等等。 Linux kernel常用的档名为：vmlinuz，如果使用的是grub2这个开机管理程式，则还会存在/boot/grub2/这个目录喔！ |
| /dev                               | 在Linux系统上，任何装置与周边设备都是以档案的型态存在于这个目录当中的。你只要透过存取这个目录底下的某个档案，就等于存取某个装置啰～比要重要的档案有/dev/null, /dev/zero, /dev/tty , /dev/loop*, / dev/sd*等等 |
| /etc                               | 系统主要的设定档几乎都放置在这个目录内，例如人员的帐号密码档、各种服务的启始档等等。一般来说，这个目录下的各档案属性是可以让一般使用者查阅的，但是只有root有权力修改。FHS建议不要放置可执行档(binary)在这个目录中喔。比较重要的档案有： /etc/modprobe.d/, /etc/passwd, /etc/fstab, /etc/issue等等。另外FHS还规范几个重要的目录最好要存在/etc/目录下喔：/etc/opt(必要)：这个目录在放置第三方协力软体/opt的相关设定档/etc/X11/(建议)：与X Window有关的各种设定档都在这里，尤其是xorg.conf这个X Server的设定档。/etc/sgml/(建议)：与SGML格式有关的各项设定档/etc/xml/(建议)：与XML格式有关的各项设定档 |
| /lib                               | 系统的函式库非常的多，而/lib放置的则是在开机时会用到的函式库，以及在/bin或/sbin底下的指令会呼叫的函式库而已。什么是函式库呢？妳可以将他想成是『外挂』，某些指令必须要有这些『外挂』才能够顺利完成程式的执行之意。另外FHS还要求底下的目录必须要存在：/lib/modules/：这个目录主要放置可抽换式的核心相关模组(驱动程式)喔！ |
| /media                             | media是『媒体』的英文，顾名思义，这个/media底下放置的就是可移除的装置啦！ 包括软碟、光碟、DVD等等装置都暂时挂载于此。常见的档名有：/media/floppy, /media/cdrom等等。 |
| /mnt                               | 如果妳想要暂时挂载某些额外的装置，一般建议妳可以放置到这个目录中。在古早时候，这个目录的用途与/media相同啦！只是有了/media之后，这个目录就用来暂时挂载用了。 |
| /opt                               | 这个是给第三方协力软体放置的目录。什么是第三方协力软体啊？举例来说，KDE这个桌面管理系统是一个独立的计画，不过他可以安装到Linux系统中，因此KDE的软体就建议放置到此目录下了。另外，如果妳想要自行安装额外的软体(非原本的distribution提供的)，那么也能够将你的软体安装到这里来。不过，以前的Linux系统中，我们还是习惯放置在/usr/local目录下呢！ |
| /run                               | 早期的FHS 规定系统开机后所产生的各项资讯应该要放置到/var/run 目录下，新版的FHS 则规范到/run 底下。由于/run 可以使用记忆体来模拟，因此效能上会好很多！ |
| /sbin                              | Linux有非常多指令是用来设定系统环境的，这些指令只有root才能够利用来『设定』系统，其他使用者最多只能用来『查询』而已。 放在/sbin底下的为开机过程中所需要的，里面包括了开机、修复、还原系统所需要的指令。 至于某些伺服器软体程式，一般则放置到/usr/sbin/当中。至于本机自行安装的软体所产生的系统执行档(system binary)，则放置到/usr/local/sbin/当中了。常见的指令包括：fdisk, fsck, ifconfig, mkfs等等。 |
| /srv                               | srv可以视为『service』的缩写，是一些网路服务启动之后，这些服务所需要取用的资料目录。常见的服务例如WWW, FTP等等。举例来说，WWW伺服器需要的网页资料就可以放置在/srv/www/里面。不过，系统的服务资料如果尚未要提供给网际网路任何人浏览的话，预设还是建议放置到/var/lib 底下即可。 |
| /tmp                               | 这是让一般使用者或者是正在执行的程序暂时放置档案的地方。这个目录是任何人都能够存取的，所以你需要定期的清理一下。当然，重要资料不可放置在此目录啊！因为FHS甚至建议在开机时，应该要将/tmp下的资料都删除唷！ |
| /usr                               | 第二层FHS 设定，后续介绍                                     |
| /var                               | 第二层FHS 设定，主要为放置变动性的资料，后续介绍             |

| 目录                               | 应放置档案内容                                               |
| ---------------------------------- | ------------------------------------------------------------ |
| 第一部份：FHS 要求必须要存在的目录 |                                                              |
| /usr/bin/                          | 所有一般用户能够使用的指令都放在这里！目前新的CentOS 7 已经将全部的使用者指令放置于此，而使用连结档的方式将/bin 连结至此！也就是说， /usr/bin 与/bin 是一模一样了！另外，FHS 要求在此目录下不应该有子目录！ |
| /usr/lib/                          | 基本上，与/lib 功能相同，所以/lib 就是连结到此目录中的！     |
| /usr/local/                        | 系统管理员在本机自行安装自己下载的软体(非distribution预设提供者)，建议安装到此目录， 这样会比较便于管理。举例来说，你的distribution提供的软体较旧，你想安装较新的软体但又不想移除旧版， 此时你可以将新版软体安装于/usr/local/目录下，可与原先的旧版软体有分别啦！你可以自行到/usr/local去看看，该目录下也是具有bin, etc, include, lib...的次目录喔！ |
| /usr/sbin/                         | 非系统正常运作所需要的系统指令。最常见的就是某些网路伺服器软体的服务指令(daemon)啰！不过基本功能与/sbin 也差不多， 因此目前/sbin 就是连结到此目录中的。 |
| /usr/share/                        | 主要放置唯读架构的资料档案，当然也包括共享文件。在这个目录下放置的资料几乎是不分硬体架构均可读取的资料， 因为几乎都是文字档案嘛！在此目录下常见的还有这些次目录：/usr/share/man：线上说明文件/usr/share/doc：软体杂项的文件说明/usr/share/zoneinfo：与时区有关的时区档案 |
| 第二部份：FHS 建议可以存在的目录   |                                                              |
| /usr/games/                        | 与游戏比较相关的资料放置处                                   |
| /usr/include/                      | c/c++等程式语言的档头(header)与包含档(include)放置处，当我们以tarball方式(*.tar.gz 的方式安装软体)安装某些资料时，会使用到里头的许多包含档喔！ |
| /usr/libexec/                      | 某些不被一般使用者惯用的执行档或脚本(script)等等，都会放置在此目录中。例如大部分的X视窗底下的操作指令，很多都是放在此目录下的。 |
| /usr/lib<qual>/                    | 与/lib<qual>/功能相同，因此目前/lib<qual> 就是连结到此目录中 |
| /usr/src/                          | 一般原始码建议放置到这里，src有source的意思。至于核心原始码则建议放置到/usr/src/linux/目录下。 |

### vim编辑器

#### 进入编辑模式

```shell
i/a/o/I/A/O
```

退出编辑（先执行esc，推出编辑模式）

注意：vim对大小写敏感

```shell
#退出编辑页码
:q
#保存内容并退出编辑页
:wq
#强制退出（进行了编辑，但不想保存，且权限不够）
:q!
#强制保存并退出(操作权限不够)
:wq!
#强制保存
:w!
```

#### 常用的编辑命令

| 命令                  | 涵义                                                         |
| --------------------- | ------------------------------------------------------------ |
| dd                    | 删除游标所在的行                                             |
| ndd                   | 删除游标向下n行                                              |
| yy                    | 复制游标所在的行                                             |
| p/P                   | 粘贴复制的内容到游标的下一行/上一行                          |
| nyy                   | 复制游标向下的n行                                            |
| /word                 | 向游标之下寻找字符串                                         |
| ?word                 | 向游标之上寻找字符串                                         |
| n/N                   | 重复向下/向上搜索                                            |
| x/X                   | 向前/向后删除字元（游标处）                                  |
| nx                    | 连续向后删除n个字元                                          |
| n<Enter>              | n为数字。游标向下移动n列                                     |
| :n1,n2s/word1/word2/g | n1与n2为数字。在第n1与n2列之间寻找word1这个字串，并将该字串取代为word2 ！举例来说，在100到200列之间搜寻vbird并取代为VBIRD则： 『:100,200s/vbird/VBIRD/g』。 |
| :1,$s/word1/word2/g   | 从第一列到最后一列寻找word1字串，并将该字串取代为word2 ！    |
| :1,$s/word1/word2/gc  | 从第一列到最后一列寻找word1字串，并将该字串取代为word2 ！且在取代前显示提示字元给使用者确认(confirm)是否需要取代！ |
| u                     | **复原**前一个动作。                                         |
| :set nu               | 显示行号，设定之后，会在每一列的字首显示该列的行号           |
| :set nonu             | 与set nu 相反，为取消行号！                                  |
| ctrl+v                | 先择区块，之后按y即复制，将光标移动到想要粘贴的位置按p粘贴   |

![image-20201128152650079](../%E5%9B%BE%E7%89%87/image-20201128152650079.png)

| 多视窗情况下的按键功能 |                                                              |
| ---------------------- | ------------------------------------------------------------ |
| :sp [filename]         | 开启一个新视窗，如果有加filename， 表示在新视窗开启一个新档案，否则表示两个视窗为同一个档案内容(同步显示)。 |
| [ctrl]+w+ j [ctrl]+w+↓ | 按键的按法是：先按下[ctrl] 不放， 再按下w 后放开所有的按键，然后再按下j (或向下方向键)，则游标可移动到下方的视窗。 |
| [ctrl]+w+ k [ctrl]+w+↑ | 同上，不过游标移动到上面的视窗。                             |
| [ctrl]+w+ q            | 其实就是:q 结束离开啦！举例来说，如果我想要结束下方的视窗，那么利用[ctrl]+w+↓ 移动到下方视窗后，按下:q 即可离开， 也可以按下[ctrl]+w+q 啊！ |
| **:e!**                | **将文档恢复为初始状态**                                     |

#### head 

```shell
head -n number filename
```

使用head命令若不加参数则默认显示前十行

```
#查看文件前3行
head -n 3 helloText
#显示文件名
[root@master opt]# head -v helloText
==> helloText <==
hello linux:
#退出编辑页码
:q
#保存内容并退出编辑页
:wq
#强制退出（进行了编辑，但不想保存，且权限不够）
:q!
#强制保存并退出(操作权限不够)
:wq!
#强制保存
#不显示文件名
[root@master opt]# head -p helloText
#显指文件前指定字符数内容
[root@master opt]# head -c 10 helloText
hello linu[root@master opt]# 
```

### 文件控制

#### cp 

复制命令

```shell
#复制文件到指定文件
cp 参数 源文件对象 目标文件对象
cp hello.txt hell.txt
#强行复制文件或目录
cp -f 源文件对象 目标文件对象
#复制前进行询问
cp -i hello.txt hell.txt
[root@master opt]# cp -i hello.txt hell.txt
cp: overwrite ‘hell.txt’?
#对源文件建立硬连接而非复制文件
[root@master opt]# cp -l hello.txt hell.txt
cp: overwrite ‘hello.txt’? y
#保留源文件或目录的属性
cp -p hello.txt hell.txt
#显示执行详情
cp -v hello.txt hell.txt
#当文件的更改时间或对应名称不存在时才进行复制
cp -u hello.txt hell.txt
#将文件、目录复制给其他虚拟机

```

scp

对于不同主机之间的复制操作

```shell
#将当前主机文件复制给其他主机
scp 源文件路径 远程用户名@IP地址：远程目标文件的绝对路径
scp /opt/hello.txt root@192.168.137.111:/opt/
#将其他主机的文件复制到当前主机
scp 远程用户名@IP地址：远程目标文件的绝对路径 当前主机的目标路径
```

#### touch

功能：

1、如果文件不存在，则新建文件夹

2、如果文件存在，则更新时间标签

```shell
# 只更改读取时间（使用ls/ll中的--full-time显示的是文件的修改时间 使用-a参数较少）
touch -a hell.txt
[root@master vitest]# ls --full-time
total 16
-rw-r--r--. 1 root root 106 2020-11-28 16:12:07.635332935 +0800 hello
-rw-r--r--. 1 root root 107 2020-11-28 16:24:16.033358292 +0800 helloText
-rwxr-xr-x. 1 root root  29 2020-11-30 15:36:11.403308510 +0800 hell.txt
-rw-r--r--. 1 root root  92 2020-11-28 15:16:59.585217773 +0800 text
[root@master vitest]# touch -a hell,txt
[root@master vitest]# ls --full-time
total 16
-rw-r--r--. 1 root root 106 2020-11-28 16:12:07.635332935 +0800 hello
-rw-r--r--. 1 root root 107 2020-11-28 16:24:16.033358292 +0800 helloText
-rw-r--r--. 1 root root   0 2020-11-30 15:52:57.711343542 +0800 hell,txt
-rwxr-xr-x. 1 root root  29 2020-11-30 15:36:11.403308510 +0800 hell.txt
-rw-r--r--. 1 root root  92 2020-11-28 15:16:59.585217773 +0800 text
#更改文件被修改时间（使用ls/ll中的--full-time显示的是文件的修改时间）
[root@master vitest]# touch -m hell.txt
[root@master vitest]# ls --full-time hell.txt
-rwxr-xr-x. 1 root root 29 2020-11-30 16:02:11.976362837 +0800 hell.txt
#不创建任何文件或目录
[root@master vitest]# touch -c /opt/hell
[root@master vitest]# ls
hello  helloText  hell,txt  hell.txt  text
#解析时间字符串并使用它代替当前时间
touch -d hell.txt 12:30:55
```

#### mv

1、重命名

2、移动

```shell
#更改文件名
mv 原文件名 修改文件名
[root@master vitest]# mv hell.txt helloword.txt
[root@master vitest]# ls
hello  helloText  helloword.txt  hell,txt  text
#移动文件/文件夹
[root@master vitest]# mv helloword.txt /opt
[root@master vitest]# ls ../
hellolinux  helloText  hello.txt  helloword.txt  hell.txt  test1  test1.gz  vistest  vitest
#-i 参数，当目标地址有该文件时则会询问用户是否覆盖，若没有则直接移动
mv -i text /opt
#当源文件比目标文件新或者目标文件不存在时才执行此操作
mv -u text /opt
#当目标地址中与源文件/目录重复，则进行覆盖
mv -f text /opt
#显示详细信息
[root@master vitest]# mv -v text /opt
mv: overwrite ‘/opt/text’? y
‘text’ -> ‘/opt/text’
#若需要覆盖文件则先进行备份再进行覆盖
mv --backup 

```

mkdir

mkdir 参数 目标文件

```shell
#创建文件夹
mkdir data
#创建文件并同时设定权限
mkdir -m 权限 文件夹名称
#若创建的目录上级不存再则会一并创建上级目录
mkdir -p /opt/dat/vi
[root@master vitest]# ls ../
dat  hellolinux  helloText  hello.txt  helloword.txt  hell.txt  test1  test1.gz  text  vistest  vitest
```

#### rm

删除文件夹/目录、

```shell
#删除文件夹
rm -r 目标文件夹名称
rm -r dat
#强制删除文件夹
rm -rf 目标文件夹
rm -rf /opt/dat
#删除空文件夹
rm -d /dat
```

####   rmdir

删除空文件夹

```shell
rmdir 目标文件夹名称
rmdir ds
rmdir -p 删除指定目录后 若父目录为空则一并删除
rmdir -p /opt/dat/sd
```

#### grep

查找文件中符合条件的字符串

```shell
#以递归的方式查找符合条件的文件（例：查找此目录下存在hello的文件）
grep -r 字符串
[root@master opt]# grep -r hello
hell.txt:hello word!
Binary file .helloText.swp matches
hellolinux:hello linux:
vitest/hello:#hello world
vitest/helloText:#hello world
helloText:hello linux:
vistest:hello linux:
hello.txt:hello linux:
helloword.txt:hello word!
#查找文件中包含查找字符的行
grep 查找的字符串 文件名
[root@master opt]# grep hello helloText 
hello linux:
#以递归的方式查找不符合条件的文件
grep -v 字符串 目标文件
[root@master opt]# grep -v hello hell.txt
welocme to linux
#统计文件中包含字符串的行数
grep -c "字符串" 文件名称
[root@master opt]# grep -c "hello" hell.txt
1
#输出包含该字符串的行数及其内容
grep "字符串" -n 文件名称
[root@master opt]# grep "hello" -n hell.txt helloText
hell.txt:1:hello word!
helloText:1:hello linux:
#将匹每一个配项单独一行输出
grep -o "字符串" 文件名称
[root@master opt]# grep -o "he" helloText
he
he
#统计某一字符在文件中出现的次数
grep -o "字符串" 文件名称 | wc -l
[root@master opt]# grep -o "he" helloText | wc -l
2
#忽略大小写
gerp -i "字符串" 文件名
[root@master opt]# grep -i "hE" helloText
hello linux:
if you have any question you can concat with her!
#忽略大小写，并输出出现行数
[root@master opt]# grep -ic "hE" helloText
2

```

#### ps

产看进程

```shell
#查看一个终端中的所有进行
ps -a 
#查看系统中的所有进程
ps -aux
#查看所有进行程
ps -e
#查看当前按shell产生的进程
ps -l
#查看进程数量
ps aux | wc -l
```

#### find

