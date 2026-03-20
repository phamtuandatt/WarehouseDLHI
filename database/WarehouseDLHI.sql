-- Module core - Nền tảng chung
CREATE TABLE Companies (
    id              INT PRIMARY KEY,
    code            VARCHAR(20) UNIQUE NOT NULL,
    name            NVARCHAR(255) NOT NULL,
    tax_code        VARCHAR(20),
    address         TEXT,
    phone           VARCHAR(20),
    email           VARCHAR(100),
    currency_code   VARCHAR(3) DEFAULT 'VND',
    is_active       BIT DEFAULT 1,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng departments — Phòng ban
CREATE TABLE Departments (
    dept_id         INT PRIMARY KEY,
    company_id      INT REFERENCES Companies(id),
    code            VARCHAR(20) NOT NULL,
    name            NVARCHAR(255) NOT NULL,
    is_active       INT DEFAULT 1,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(company_id, code)
);

-- Bảng Chức vụ
CREATE TABLE Positions (
    pos_id		INT IDENTITY(1,1) PRIMARY KEY,
    pos_name	NVARCHAR(100) NOT NULL UNIQUE, -- Ví dụ: Chỉ huy trưởng, Kỹ sư kết cấu
    base_salary DECIMAL(18, 2) DEFAULT 0 -- Lương cơ bản để tính toán sau này
);

-- Bảng Employees - Nhân viên
CREATE TABLE Employees (
    emp_id INT IDENTITY(1,1) PRIMARY KEY,
    emp_guid UNIQUEIDENTIFIER DEFAULT NEWID(), -- ID duy nhất toàn cầu cho việc đồng bộ
    emp_code VARCHAR(20) NOT NULL UNIQUE,      -- Mã nhân viên (Ví dụ: NV001)
    first_name  NVARCHAR(100) NOT NULL,
    last_name   NVARCHAR(100) NOT NULL,
    
    -- Cú pháp chuẩn cho SQL Server:
    full_name AS (last_name + ' ' + first_name) PERSISTED, 
    gender NVARCHAR(10),
    birth_date DATE,
    id_card VARCHAR(20),       -- Số CCCD/Passport
    phone VARCHAR(20),
    email VARCHAR(100),
    address NVARCHAR(255),
    
    -- Liên kết phòng ban và chức vụ
    dept_id INT,
    pos_id INT,
    
    -- Quản lý trực tiếp (Self-reference)
    manager_id INT NULL, 
    
    join_date DATE DEFAULT GETDATE(),
    status NVARCHAR(50) DEFAULT N'Đang làm việc', -- Đang làm việc, Thử việc, Đã nghỉ
    
    -- Khai báo khóa ngoại
    CONSTRAINT FK_Emp_Dept FOREIGN KEY (dept_id) REFERENCES Departments(dept_id) ON DELETE SET NULL,
    CONSTRAINT FK_Emp_Pos FOREIGN KEY (pos_id) REFERENCES Positions(pos_id) ON DELETE SET NULL,
    CONSTRAINT FK_Emp_Manager FOREIGN KEY (manager_id) REFERENCES Employees(emp_id)
);

-- 4. TẠO BẢNG TÀI KHOẢN & PHÂN QUYỀN (SYSTEM USERS)

CREATE TABLE Users (
    user_id INT PRIMARY KEY, -- Liên kết 1-1 với emp_id
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(MAX) NOT NULL,
    role_level NVARCHAR(50) DEFAULT 'Staff', -- Admin, Manager, Staff
    is_active BIT DEFAULT 1,
    
    CONSTRAINT FK_User_Emp FOREIGN KEY (user_id) REFERENCES Employees(emp_id) ON DELETE CASCADE
);

-- Bảng currencies & exchange_rates
CREATE TABLE Currencies (
    code            VARCHAR(3) PRIMARY KEY,   -- VND, USD, EUR
    name            VARCHAR(100) NOT NULL,
    symbol          VARCHAR(10),
    decimal_places  INT DEFAULT 0,
    is_active       BIT DEFAULT 1
);

CREATE TABLE Exchange_rates (
    id              INT PRIMARY KEY,
    from_currency   VARCHAR(3) REFERENCES Currencies(code),
    to_currency     VARCHAR(3) REFERENCES Currencies(code),
    rate            DECIMAL(18,6) NOT NULL,
    effective_date  DATE NOT NULL,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(from_currency, to_currency, effective_date)
);

-- Khách hàng
CREATE TABLE Customer_type (
	id					INT PRIMARY KEY,
	customer_type_name	NVARCHAR(50)
)

CREATE TABLE Customers (
    id					INT PRIMARY KEY,
    code				VARCHAR(20),
    name				NVARCHAR(255) NOT NULL,
    cus_type_id			INT REFERENCES Customer_type(id) ON DELETE SET NULL,
    tax_code			VARCHAR(20),
    contact_person		VARCHAR(100),
    phone				VARCHAR(20),
    email				VARCHAR(100),
    address				TEXT,
    credit_limit		DECIMAL(18,2) DEFAULT 0,
    payment_term_days	INT DEFAULT 30,
    is_active			BIT DEFAULT 1, -- 1 ? true : 0 false
    created_at			TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at			TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(code)
);

-- Project
CREATE TABLE projects (
	id					INT PRIMARY KEY,
	name				NVARCHAR(50),
	code				VARCHAR(50),
	project_no			VARCHAR(50),
	info				VARCHAR(100),
	wo_no				VARCHAR(50),
	customer_id			INT REFERENCES customers(id) ON DELETE SET NULL,
	budget				DECIMAL(18,2),
	total_order_amount	DECIMAL(18,2),
	total_mpr_created	INT,
	total_po_created	INT,
	remaining_budget	AS (budget - total_order_amount)
)
-- Unit
CREATE TABLE Units (
	id			INT PRIMARY KEY,
	name		NVARCHAR(50),
	unit_price	DECIMAL(18, 2),
)

-- Material Categories - Danh mục vật tư (Main, Fitting,...)
CREATE TABLE Material_Categories (
    cat_id		INT IDENTITY(1,1) PRIMARY KEY,
    cat_name	NVARCHAR(100) NOT NULL,
);

-- Bảng vật tư
CREATE TABLE Materials (
    material_id		INT IDENTITY(1,1) PRIMARY KEY,
    material_code	VARCHAR(50) NOT NULL UNIQUE,
    material_name	NVARCHAR(255) NOT NULL,
    specifications	NVARCHAR(MAX),
    created_at  	DATETIME DEFAULT GETDATE(),

    cat_id			INT NOT NULL,
    unit_id			INT,
    CONSTRAINT FK_Material_Category FOREIGN KEY (cat_id) REFERENCES Material_Categories(cat_id),
);
-- Chi tiết vật tư 
CREATE TABLE Material_Detail (
	material_detail_id		INT PRIMARY KEY,
	material_detail_code	VARCHAR(50),
	material_detail_number	VARCHAR(5),
	material_detail_name	NVARCHAR(100),

	CONSTRAINT FK_Material_Detail_Materials FOREIGN KEY (material_detail_id) REFERENCES Materials(material_id)
)

---- Bảng Lịch sử Nhập/Xuất kho (Để quản lý tồn kho chặt chẽ)
--CREATE TABLE Inventory_Transactions (
--    trans_id INT IDENTITY(1,1) PRIMARY KEY,
--    material_id INT,
--    trans_type NVARCHAR(20), -- 'IMPORT' (Nhập), 'EXPORT' (Xuất)
--    quantity DECIMAL(18, 2),
--    trans_date DATETIME DEFAULT GETDATE(),
--    note NVARCHAR(255),
--    emp_id INT, -- Ai là người thực hiện (Liên kết module HRM)
--    CONSTRAINT FK_Trans_Material FOREIGN KEY (material_id) REFERENCES Materials(material_id),
--    CONSTRAINT FK_Trans_Emp FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
--);