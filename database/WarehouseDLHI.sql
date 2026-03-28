CREATE DATABASE WAREHOUSE_DLHI_VINA

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

-- Nhà cung cấp - Supplier
CREATE TABLE Suppliers (
    supplier_id		INT IDENTITY(1,1) PRIMARY KEY,
    supplier_code	VARCHAR(20) UNIQUE, -- Ví dụ: NCC-HOAPHAT
    supplier_name	NVARCHAR(255) NOT NULL,
    cert			VARCHAR(50),
	tax_code		VARCHAR(20),
    address			NVARCHAR(500),
    contact_person	NVARCHAR(100),
    phone			VARCHAR(20),
    email			VARCHAR(100)
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
CREATE TABLE Projects (
	id					INT PRIMARY KEY,
	name				NVARCHAR(50),
	code				VARCHAR(50),
	project_no			VARCHAR(50),
	info				VARCHAR(100),
	wo_no				VARCHAR(50),
	customer_id			INT REFERENCES Customers(id) ON DELETE SET NULL,
	budget				DECIMAL(18,2),
	total_order_amount	DECIMAL(18,2),
	total_mpr_created	INT,
	total_po_created	INT,
	remaining_budget	AS (budget - total_order_amount)
)
------------------------------------------------------------------------------------------------------------------------------------------------------
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
----------------------------------------------------------------START MODULE PRODUCT------------------------------------------------------------------
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
---------------------------------------------------------------Đã tạo bảng----------------------------------------------------------------------------
-- Unit
CREATE TABLE Units (
	id			INT PRIMARY KEY,
	name		NVARCHAR(50),
	unit_price	DECIMAL(18, 2),
)

-- Origins
CREATE TABLE Origins (
	id		INT IDENTITY(1,1) PRIMARY KEY,
	code	VARCHAR(20),
	name	NVARCHAR(MAX),
)

-- Standard
CREATE TABLE Standards (
	id		INT IDENTITY(1,1) PRIMARY KEY,
	code	VARCHAR(20),
	name	NVARCHAR(225)
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
    material_name	NVARCHAR(255),
    specifications	NVARCHAR(MAX),
    created_at  	DATETIME DEFAULT GETDATE(),

    cat_id			INT NOT NULL,
    unit_id			INT,
    CONSTRAINT FK_Material_Category FOREIGN KEY (cat_id) REFERENCES Material_Categories(cat_id),
);
-- Chi tiết vật tư 
CREATE TABLE Material_Detail (
	material_detail_id		INT PRIMARY KEY,
	material_detail_number	VARCHAR(5),
	material_detail_name	NVARCHAR(100),
	material_detail_code	VARCHAR(50),

	CONSTRAINT FK_Material_Detail_Materials FOREIGN KEY (material_detail_id) REFERENCES Materials(material_id)
)

-- Bảng sản phẩm
CREATE TABLE Products (
	id					INT IDENTITY(1,1) PRIMARY KEY,
	name				NVARCHAR(50),
	des_2				NVARCHAR(50),
	code				VARCHAR(50),
	prod_material_code	VARCHAR(50), -- Standard name
	picture_link		NVARCHAR(200),
	picture				VARBINARY(MAX),
	a_thinkness			VARCHAR(10),
	b_depth				VARCHAR(10),
	c_witdth			VARCHAR(10),
	d_web				VARCHAR(10),
	e_flag				VARCHAR(10),
	f_length			VARCHAR(10),
	g_weight			VARCHAR(10),
	used_note			NVARCHAR(100),
	 
	-- Mở rộng -> Tạo khóa ngoại
	prod_origin_id			INT DEFAULT NULL,	-- Origin: DO (trong nước), P1 (Nhập miễn thuế),...
	prod_standard_id		INT DEFAULT NULL,	-- Standard: 000, 0001,... (A363, A572,...)
	prod_material_cate_id	INT DEFAULT NULL,	-- Material_Categories: Main, Fitting,...
	prod_material_id		INT DEFAULT NULL,	-- Material: Plate, Beam,...
	prod_material_detail_id	INT DEFAULT NULL,	-- Material_detail: Plate dày, plate mỏng,...
)
------------------------------------------------------------------------------------------------------------------------------------------------------
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
----------------------------------------------------------------END MODULE PRODUCT--------------------------------------------------------------------
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
----------------------------------------------------------------START MODULE INVENTORY----------------------------------------------------------------
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE Project_Stock (
    project_stock_id	INT IDENTITY(1,1) PRIMARY KEY, -- ID tự tăng của hệ thống
    project_id			INT NOT NULL,                  -- Liên kết đến dự án cụ thể
    product_id			INT NOT NULL,                  -- Liên kết đến loại vật tư cụ thể
    on_hand_qty			DECIMAL(18, 4) DEFAULT 0,      -- Số lượng thực tế đang tồn tại dự án
    last_updated		DATETIME DEFAULT GETDATE(),    -- Thời điểm cập nhật cuối cùng
    storage_location	NVARCHAR(100) NULL,            -- Vị trí để (Khu vực A, Lán trại B,...)
    
    -- Các ràng buộc (Constraints) để đảm bảo dữ liệu "sạch"
    CONSTRAINT FK_Stock_Project FOREIGN KEY (project_id) REFERENCES Projects(id),
    CONSTRAINT FK_Stock_Material FOREIGN KEY (product_id) REFERENCES Products(id),
    
    -- Ràng buộc UNIQUE: Đảm bảo một dự án không bị lặp lại dòng cho cùng một mã vật tư
    CONSTRAINT UQ_Project_Material UNIQUE (project_id, product_id),
    
    -- Ràng buộc CHECK: Đảm bảo tồn kho không bị âm (Tùy chọn)
    CONSTRAINT CHK_NonNegative_Stock CHECK (on_hand_qty >= 0)
);

-- Project Import
GO
CREATE TABLE Project_Import_Inventory_Transactions (
    p_i_trans_id	INT IDENTITY(1,1) PRIMARY KEY,
    project_id		INT,
	project_code	VARCHAR(50),
    trans_type		NVARCHAR(20) DEFAULT 'PROJECT_IMPORT', -- 'PROJECT_IMPORT' (Nhập về DA)
    total_quantity	DECIMAL(18, 2),
    i_trans_date	DATETIME DEFAULT GETDATE(),
    po_no			VARCHAR(50), -- Số phiếu PO hoặc số lệnh sản xuất -> Nhập hàng theo PO nào
	import_no		VARCHAR(50), -- Số phiếu nhập kho
	invoice_no		VARCHAR(50), -- Số hóa đơn
    note			NVARCHAR(255),

	supplier_id		INT, -- Của nhà cung cấp nào
    emp_id			INT, -- Người thực hiện (Module HRM)
	emp_name		NVARCHAR(100),
	po_id			INT, -- Trans này của PO nào

	CONSTRAINT FK_P_Trans_Project FOREIGN KEY (project_id) REFERENCES Projects(id),
    CONSTRAINT FK_P_Trans_Emp FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
)

GO
CREATE TABLE Project_Import_Invetory_Details (
	p_i_detail_id	INT IDENTiTY(1,1) PRIMARY KEY,
	p_i_trans_id	INT, -- ID Trans,
	product_id		INT, -- 
	import_qty		DECIMAL(18,2),
	unit			VARCHAR(20),
	time			INT, -- Số lần nhập - nhập lần 1 - 20psc, nhập lần 2 - 10psc => đủ
	note			NVARCHAR(MAX),

	CONSTRAINT FK_P_Import_Inventory_Detail_P_Import_Trans FOREIGN KEY (p_i_trans_id) REFERENCES Project_Import_Inventory_Transactions(p_i_trans_id),
	CONSTRAINT FK_P_Trans_Products FOREIGN KEY (product_id) REFERENCES Products(id),
)

-- Project Usage
GO
CREATE TABLE Project_Usage_Inventory_Transactions (
    p_u_trans_id	INT IDENTITY(1,1) PRIMARY KEY,
    project_id		INT,
	project_code	VARCHAR(50),
    trans_type		NVARCHAR(20) DEFAULT 'PROJECT_USAGE', -- Lấy sử dụng
    total_quantity	DECIMAL(18, 2),
    u_trans_date	DATETIME DEFAULT GETDATE(),
    reference_no	VARCHAR(50), -- Số phiếu xuất kho
	u_for_dep		VARCHAR(50), -- Xuất cho bộ phận nào
	emp_name_get	NVARCHAR(100),
    note			NVARCHAR(255),

    emp_id			INT, -- Người thực hiện (Module HRM)
	emp_name		NVARCHAR(50), -- Tên người thực hiện

	CONSTRAINT FK_P_Trans_Project FOREIGN KEY (project_id) REFERENCES Projects(id),
    CONSTRAINT FK_P_Trans_Emp FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
)

GO
CREATE TABLE Project_Usage_Invetory_Details (
	p_u_detail_id	INT IDENTiTY(1,1) PRIMARY KEY,
	p_u_trans_id	INT, -- ID Trans,
	product_id		INT, -- 
	usage_qty		DECIMAL(18,2),
	unit			VARCHAR(20),
	time			INT, -- Số lần xuất
	note			NVARCHAR(MAX),

	CONSTRAINT FK_P_Usage_Inventory_Detail_P_Usage_Trans FOREIGN KEY (p_u_trans_id) REFERENCES Project_Usage_Inventory_Transactions(p_u_trans_id),
	CONSTRAINT FK_P_Trans_Products FOREIGN KEY (product_id) REFERENCES Products(id),
)

--------------------------------TYPE--------------------------
-- Type cho chi tiết nhập
CREATE TYPE udt_ProjectImportDetail AS TABLE (
    product_id INT,
    import_qty DECIMAL(18,2),
    unit VARCHAR(20),
    time INT,
    note NVARCHAR(MAX)
);
GO

-- Type cho chi tiết xuất (sử dụng)
CREATE TYPE udt_ProjectUsageDetail AS TABLE (
    product_id INT,
    usage_qty DECIMAL(18,2),
    unit VARCHAR(20),
    time INT,
    note NVARCHAR(MAX)
);
GO
------------------------------------------------------------------------------------------------------------------------------------------------------
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
------------------------------------------------------------------END MODULE INVENTORY----------------------------------------------------------------
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
------------------------------------------------------------------------------------------------------------------------------------------------------

-- Thông tin chung của phiếu yêu cầu
CREATE TABLE MPR_Header (
    mpr_id					INT IDENTITY(1,1) PRIMARY KEY,
    mpr_no					VARCHAR(50) UNIQUE, -- Mã phiếu tự sinh (VD: MPR-2026-0001)
	mpr_rev_total			INT, -- Update khi tạo Rev cho MPR hiện tại
    request_date			DATE DEFAULT GETDATE(),
	created_date			DATE DEFAULT GETDATE(),
	expected_delivery_date	DATE DEFAULT DATEADD(day, 7, GETDATE()),
	is_make_po				BIT DEFAULT 0, -- 1 true, 0 false
	is_cancaled				BIT DEFAULT 0, -- 1 true, 0 false
    status					NVARCHAR(50) DEFAULT N'Pending', -- Pending, Approved, Rejected, Ordered
    note					NVARCHAR(MAX),
	--old_value_mpr			VARCHAR(MAX),
	--new_value_mpr			VARCHAR(MAX),

	-- Kiểm soát số lượng vật tư tổng, đã đặt, phần trăm hoàn thành
	mpr_total_qty			INT, -- Tổng số lượng vật tư trong MPR
	mpr_order_qty			INT, -- Số lượng vật tư đã làm PO -> Update sau khi tạo PO
	mpr_remaining_qyt		AS (mpr_total_qty - mpr_order_qty), 
	process_per				AS ((mpr_order_qty / mpr_total_qty) * 0.1),

	-- Ai làm, ai review, ai duyệt
	preparer_name			NVARCHAR(50),
	reviewer_name			NVARCHAR(50),
	approver_name			NVARCHAR(50),
	preparer_id				INT, -- Emp id
	reviewer_id				INT, -- Emp id
	approver_id				INT, -- Emp id
	requester_id			INT, -- Emp id

	-- Của dự án nào
    project_id				INT,   -- Liên kết Projects
    CONSTRAINT FK_MPR_Employee FOREIGN KEY (project_id) REFERENCES Projects(id)
);

-- Chi tiết các vật tư trong phiếu yêu cầu
CREATE TABLE MPR_Details (
    mpr_detail_id			INT IDENTITY(1,1) PRIMARY KEY,
    mpr_id					INT,
    product_id				INT,
	usage					VARCHAR(50),
	MPS						VARCHAR(50),
	REV						INT DEFAULT 0, -- Sẽ được cập nhật nếu được revise
	draw_recevie_date		DATE DEFAULT GETDATE(),
	issue_date				DATE DEFAULT GETDATE(),
	unit					VARCHAR(20),
    requested_qty			INT,
	weight					FLOAT,
	remarks					NVARCHAR(255),

    created_date			DATE DEFAULT GETDATE(),
	updated_date			DATE DEFAULT GETDATE(),

    CONSTRAINT FK_MPR_Detail_Mpr_Header FOREIGN KEY (mpr_id) REFERENCES MPR_Header(mpr_id) ON DELETE CASCADE,
);

-- Lịch sử cập nhật/thêm/sửa MPR
CREATE TABLE MPR_Audit_Log (
    log_id				INT IDENTITY(1,1) PRIMARY KEY,
    mpr_id				INT,                  -- ID của phiếu MPR bị tác động
    table_name			NVARCHAR(50),     -- Tên bảng (MPR_Header hoặc MPR_Details)
    column_name			NVARCHAR(50),    -- Tên cột bị thay đổi (Số lượng, Ngày, Trạng thái...)
    old_value			NVARCHAR(MAX),     -- Giá trị trước khi sửa
    new_value			NVARCHAR(MAX),     -- Giá trị sau khi sửa
    action_type			NVARCHAR(20),    -- Loại thao tác: INSERT, UPDATE, DELETE
    changed_by_emp_id	INT,       -- ID nhân viên thực hiện (Liên kết module HRM)
    changed_at			DATETIME DEFAULT GETDATE(), -- Thời điểm thực hiện
    client_ip			VARCHAR(50),       -- IP máy tính thực hiện (nếu cần truy vết)
    
    CONSTRAINT FK_Audit_Emp FOREIGN KEY (changed_by_emp_id) REFERENCES Employees(emp_id)
);

