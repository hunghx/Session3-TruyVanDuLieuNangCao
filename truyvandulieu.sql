create database quanlybanhang;
use quanlybanhang;

create table khachhang
(
    makh     varchar(4) primary key,
    tenkh    varchar(30) not null,
    diachi   varchar(50),
    Ngaysinh date,
    soDt     varchar(11) unique
);

create table Nhanvien
(
    manv       varchar(4) primary key,
    Hoten      varchar(30) not null,
    gioitinh   bit         not null,
    diachi     varchar(50) not null,
    ngaysinh   date        not null,
    dienthoai  varchar(11) unique,
    email      varchar(255) unique,
    noisinh    varchar(20) not null,
    ngayvaolam date,
    maNQL      varchar(4)
);

create table nhacungcap
(
    mancc     varchar(5) primary key,
    tenncc    varchar(50) not null,
    diachi    varchar(50) not null,
    dienthoai varchar(11) not null unique,
    email     varchar(255) unique,
    website   varchar(100)
);

create table loaisp
(
    maloaisp  varchar(4) primary key,
    tenloaisp varchar(30)  not null,
    ghichu    varchar(100) not null
);

create table sanpham
(
    masp      varchar(4) primary key,
    maloaisp  varchar(4)  not null,
    tensp     varchar(50) not null,
    donvitinh varchar(10) not null,
    ghichu    varchar(100),
    foreign key (maloaisp) references loaisp (maloaisp)
);
alter table sanpham
modify maloaisp varchar(4);

create table phieunhap
(
    sopn     varchar(5) primary key,
    manv     varchar(4) not null,
    mancc    varchar(5) not null,
    ngaynhap datetime   not null default now(),
    ghichu   varchar(100),
    foreign key (manv) references nhanvien (manv),
    foreign key (mancc) references nhacungcap (mancc)
);

create table ctPhieunhap
(
    masp    varchar(4) not null,
    sopn    varchar(5) not null,
    soluong int        not null default 0,
    gianhap double     not null check (gianhap >= 0),
    primary key (masp, sopn),
    foreign key (masp) references sanpham (masp),
    foreign key (sopn) references phieunhap (sopn)
);
create table phieuxuat
(
    sopx    varchar(5) primary key,
    manv    varchar(4) not null,
    makh    varchar(4) not null,
    ngayban datetime   not null,
    ghichu  text,
    foreign key (manv) references nhanvien (manv),
    foreign key (makh) references khachhang (makh)
);

create table ctPhieuxuat
(
    sopx    varchar(5) not null,
    masp    varchar(4) not null,
    soluong int        not null check (soluong > 0),
    giaban  double     not null check (giaban > 0),
    primary key (masp, sopx),
    foreign key (sopx) references phieuxuat (sopx),
    foreign key (masp) references sanpham (masp)
);


# chèn dữ liệu
INSERT INTO nhanvien (manv, hoten, gioitinh, diachi, ngaysinh, dienthoai, email, noisinh, ngayvaolam, manql)
VALUES ('NV01', 'Nguyen Van A', 1, '123 Nguyen Hue, TP.HCM', '1990-01-15', '0901234567', 'nv.a@example.com', 'TP.HCM',
        '2020-01-01 08:00:00', null),
       ('NV02', 'Tran Thi B', 0, '456 Le Loi, TP.HCM', '1995-05-20', '0912345678', 'tt.b@example.com', 'TP.HCM',
        '2021-03-15 09:30:00', 'NV02'),
       ('NV03', 'Pham Van C', 1, '789 Vo Van Tan, TP.HCM', '1988-11-02', '0987654321', 'pv.c@example.com', 'TP.HCM',
        '2019-10-10 07:45:00', 'NV02');
INSERT INTO khachhang (makh, tenkh, diachi, ngaysinh, sodt)
VALUES ('KH04', 'Nguyen Thi F', '101 Nguyen Trai, TP.HCM', '1985-12-21', '0978123478'),
       ('KH02', 'Tran Van E', '202 Le Lai, TP.HCM', '1992-08-10', '0987123456'),
       ('KH03', 'Le Thi F', '303 Vo Van Tan, TP.HCM', '1989-06-18', '0918123456');

INSERT INTO nhacungcap (mancc, tenncc, diachi, dienthoai, email, website)
VALUES ('NCC01', 'Cong ty A', '15 Le Duan, TP.HCM', '0909123456', 'info@ncc-a.com', 'www.ncc-a.com'),
       ('NCC02', 'Cong ty B', '25 Nguyen Thi Minh Khai, TP.HCM', '0918234567', 'info@ncc-b.com', 'www.ncc-b.com'),
       ('NCC03', 'Cong ty C', '35 Tran Hung Dao, TP.HCM', '0987654321', 'info@ncc-c.com', 'www.ncc-c.com');
INSERT INTO loaisp (maloaisp, tenloaisp, ghichu)
VALUES ('LSP4', 'Tai Nghe', 'Các sản phẩm điện thoại di động'),
       ('LSP2', 'Laptop', 'Các sản phẩm laptop'),
       ('LSP3', 'Phụ kiện điện tử', 'Các phụ kiện điện tử');
INSERT INTO sanpham (masp, maloaisp, tensp, donvitinh, ghichu)
VALUES ('SP05', null, 'Kính', 'cái', 'Màu đen'),
       ('SP02', 'LSP1', 'Samsung Galaxy S21', 'cái', 'Màu xanh, bộ nhớ 256GB'),
       ('SP03', 'LSP2', 'Dell XPS 13', 'cái', 'Core i7, RAM 16GB');
INSERT INTO phieunhap (sopn, manv, mancc, ngaynhap, ghichu)
VALUES ('PN01', 'NV01', 'NCC01', '2023-07-10 10:30:00', 'Phiếu nhập số 1'),
       ('PN02', 'NV02', 'NCC02', '2023-07-15 15:45:00', 'Phiếu nhập số 2'),
       ('PN03', 'NV03', 'NCC03', '2023-07-20 09:00:00', 'Phiếu nhập số 3');
INSERT INTO ctphieunhap (masp, sopn, soluong, gianhap)
VALUES ('SP01', 'PN01', 50, 15000000),
       ('SP02', 'PN01', 30, 13000000),
       ('SP03', 'PN02', 20, 18000000),
       ('SP01', 'PN03', 40, 14500000);
INSERT INTO phieuxuat (sopx, manv, makh, ngayban, ghichu)
VALUES ('PX04', 'NV02', 'KH04', '2023-11-4 14:30:00', 'Phiếu xuất số 4'),
       ('PX02', 'NV02', 'KH02', '2023-08-18 10:15:00', 'Phiếu xuất số 2'),
       ('PX03', 'NV03', 'KH03', '2023-08-20 16:00:00', 'Phiếu xuất số 3');
INSERT INTO ctphieuxuat (sopx, masp, soluong, giaban)
VALUES ('PX04', 'SP01', 10, 20000000),
       ('PX04', 'SP02', 20, 18000000),
       ('PX02', 'SP03', 5, 22000000),
       ('PX03', 'SP01', 15, 19500000);


# 11.Tổng kết doanh thu theo từng khách hàng theo tháng, gồm các thông tin:
# tháng, mã khách hàng, tên khách hàng, địa chỉ, tổng tiền

select month(px.ngayban), px.makh, k.tenkh, k.diachi, sum(cp.soluong * cp.giaban)
from phieuxuat px
         join ctPhieuxuat cP on px.sopx = cP.sopx
         join khachhang k on px.makh = k.makh
group by px.makh, month(px.ngayban);


# 30.Cho biết số lượng sản phẩm loại Quần áo.
select b1.*, b2.`so luong ban`, b1.`so luong nhap` - b2.`so luong ban` `Tồn kho`
from (select cp.masp, s.tensp, sum(cp.soluong) `so luong nhap`
      from sanpham s
               join loaisp l on s.maloaisp = l.maloaisp
               join ctPhieunhap cP on s.masp = cP.masp
      where l.maloaisp like 'LSP1'
      group by cp.masp) as b1
         join
     (select cp.masp, s.tensp, sum(cp.soluong) `so luong ban`
      from sanpham s
               join loaisp l on s.maloaisp = l.maloaisp
               join ctPhieuxuat cP on s.masp = cP.masp
      where l.maloaisp like 'LSP1'
      group by cp.masp) as b2
     on b1.masp = b2.masp
;

#  18. Liệt kê các sản phẩm chưa bán được trong 6 tháng đầu năm 2018, thông tin
# gồm: mã sản phẩm, tên sản phẩm, loại sản phẩm, đơn vị tính.
select *
from sanpham
where masp not in
      (select s.masp
       from sanpham s
                join ctPhieuxuat cP on s.masp = cP.masp
                join phieuxuat p on cP.sopx = p.sopx
       where p.ngayban between '2023-6-1' and '2023-12-31');

# 26.Hãy cho biết họ tên của nhân viên và năm về hưu của họ.
select Hoten, IF(gioitinh = 1, year(ngaysinh) + 60, year(ngaysinh) + 55) `năm về hưu`
from nhanvien;
select Hoten,
       case
           when gioitinh >= 1 then year(ngaysinh) + 60
           else year(ngaysinh) + 55 end
           `năm về hưu`
from nhanvien;


# .Cho biết khách hàng có tổng trị giá đơn hàng lớn nhất trong năm.

select kh.*, sum(cp.soluong * cp.giaban)
from khachhang kh
         join phieuxuat p on kh.makh = p.makh
         join ctPhieuxuat cP on p.sopx = cP.sopx
group by p.makh
having sum(cp.soluong * cp.giaban) =
       (select sum(cp.soluong * cp.giaban)
        from phieuxuat p
                 join ctPhieuxuat cP on p.sopx = cP.sopx
        group by p.makh
        order by sum(cp.soluong * cp.giaban) desc
        limit 1);

select kh.*, sum(cp.soluong * cp.giaban)
from khachhang kh
         join phieuxuat p on kh.makh = p.makh
         join ctPhieuxuat cP on p.sopx = cP.sopx
group by p.makh
having sum(cp.soluong * cp.giaban) >= All (select sum(cp.soluong * cp.giaban)
                                           from khachhang kh
                                                    join phieuxuat p on kh.makh = p.makh
                                                    join ctPhieuxuat cP on p.sopx = cP.sopx
                                           group by p.makh);

# in ra những sản phẩm có tên sp dài hơn bất kì sản phẩm được bán trong tháng 8
select *,length(tensp) from sanpham
where length(tensp) > any
(select length(s.tensp) from sanpham s join ctPhieuxuat cP on s.masp = cP.masp
join phieuxuat p on p.sopx = cP.sopx);

#  liệt kê những sp có mã sp là SP01,SP02,SP03

#  liêt kê những sản phẩm nhập lớn hơn 20 chiếc từ trước đến nay
select *
from sanpham
where masp not in (select ct.masp
                   from ctPhieunhap ct
                   where ct.soluong > 20);

Select * from sanpham sp left join loaisp on sp.maloaisp = loaisp.maloaisp
union
Select * from sanpham sp right join loaisp on sp.maloaisp = loaisp.maloaisp
;

# tìm những sản phẩm có mã sp là SP01 và Sp02
SELECT * from sanpham where masp ='SP01'
union
SELECT tensp,masp,donvitinh,ghichu,maloaisp from sanpham where masp ='SP02';
