create database school;
use school;
create table khoa(
maKhoa char(10) primary key,
tenKhoa char(30) not null,
dienThoai char(10) not null
);
create table giangvien(
maGv int primary key,
hoTenGv char(30) not null,
luong decimal(5,2) not null,
maKhoa char(10) not null,
foreign key(maKhoa) references khoa(maKhoa)
);
create table singvien(
maSv int primary key,
hoTenSv char(30) not null,
maKhoa char(10) not null,
namSinh int not null,
queQuan char(30),
foreign key (maKhoa) references khoa(maKhoa) 
);
create table detai(
maDt char(10) primary key,
tenDt char(30) not null,
kinhPhi int not null,
NoiThucTap varchar(30)
);
create table huongdan(
maSv int,
maDt char(10),
maGv int,
ketQua decimal(5,2),
foreign key (maSv)  references singvien(maSv),
foreign key (maGv) references giangvien(maGv),
foreign key (maDt) references detai(maDt)
);
-- 1: Đưa ra thông tin gồm mã số, họ tên và tên khoa của tất cả các giảng viên
select maGv, hoTenGv ,tenKhoa 
from giangvien
left join khoa 
on giangvien.maKhoa = khoa.maKhoa;

-- 2: Đưa ra thông tin gồm mã số, họ tên và tên khoa của các giảng viên của khoa ‘toan va hoa’
select maGv, hoTenGv ,tenKhoa 
from giangvien
left join khoa 
on giangvien.maKhoa = khoa.maKhoa
where tenKhoa = 'toan' or tenKhoa ='hoa';

-- 3: Cho biết số sinh viên của khoa ‘ly’
select count(singvien.maKhoa) 
from singvien
join khoa
on singvien.maKhoa = khoa.maKhoa
where tenKhoa = 'ly';

-- 4: Đưa ra danh sách gồm mã số, họ tên và tuổi của các sinh viên khoa ‘ly’
select maSv, hoTenSv, (2020 - namSinh) as tuoi
from singvien
left join khoa
on singvien.maKhoa = khoa.maKhoa
where tenKhoa = 'ly';

-- 5: Cho biết số giảng viên của khoa ‘hoa’
select count(maGv) as 'so giang vien CNSH'
from giangvien 
left join khoa
on giangvien.maKhoa = khoa.maKhoa
where tenKhoa = 'hoa';

-- 6: Cho biết thông tin về sinh viên không tham gia thực tập
select singvien.maSv, hoTenSv, maKhoa, namSinh, queQuan 
from singvien
left join huongdan 
on singvien.maSv = huongdan.maSv
where huongdan.maSv is null;

-- 7: Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa
select khoa.maKhoa, tenKhoa, count(maGv) as 'so giang vien'
from khoa
join giangvien 
on khoa.maKhoa = giangvien.maKhoa
group by khoa.maKhoa;

-- 8: Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo học
select dienThoai 
from khoa
join singvien
on singvien.maKhoa = khoa.maKhoa
where hoTenSv = 'thi a';
-- 9: Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 3 sinh viên trở lên.
select giangvien.maGV, hoTenGv, tenKhoa 
from giangvien
join huongdan on giangvien.maGv = huongdan.maGv
join khoa on giangvien.maKhoa = khoa.maKhoa
group by huongdan.maGv
having count(huongdan.maSv) >= 3;


-- 10:Cho biết mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập
select detai.maDt, tenDt 
from detai
join huongdan on detai.maDt = huongdan.maDt
group by detai.maDt
having count(huongdan.maSv) > 2 ;

