-- ============================================================== PROC IMPORT
CREATE PROCEDURE sp_InsertProjectImport
    @project_id INT,
    @project_code INT,
    @total_quantity DECIMAL(18, 2),
    @po_no VARCHAR(50),
    @import_no VARCHAR(50),
    @invoice_no VARCHAR(50),
    @note NVARCHAR(255),
    @supplier_id INT,
    @emp_id INT,
    @emp_name NVARCHAR(100),
    @po_id INT,
    @Details udt_ProjectImportDetail READONLY -- Danh sách vật tư truyền từ C#
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Chèn bảng chính (Transactions)
        DECLARE @NewTransID INT;
        INSERT INTO Project_Import_Inventory_Transactions 
            (project_id, project_code, total_quantity, po_no, import_no, invoice_no, note, supplier_id, emp_id, emp_name, po_id)
        VALUES 
            (@project_id, @project_code, @total_quantity, @po_no, @import_no, @invoice_no, @note, @supplier_id, @emp_id, @emp_name, @po_id);
        
        SET @NewTransID = SCOPE_IDENTITY();

        -- 2. Chèn bảng chi tiết (Details)
        INSERT INTO Project_Import_Invetory_Details (p_i_trans_id, product_id, import_qty, unit, [time], note)
        SELECT @NewTransID, product_id, import_qty, unit, [time], note FROM @Details;

        -- 3. Cập nhật tồn kho thực tế (Project_Stock)
        -- Sử dụng MERGE để: Nếu có rồi thì cộng thêm, chưa có thì tạo mới dòng tồn kho
        MERGE Project_Stock AS target
        USING (SELECT product_id, SUM(import_qty) as total_qty FROM @Details GROUP BY product_id) AS source
        ON (target.project_id = @project_id AND target.product_id = source.product_id)
        WHEN MATCHED THEN
            UPDATE SET on_hand_qty = target.on_hand_qty + source.total_qty, last_updated = GETDATE()
        WHEN NOT MATCHED THEN
            INSERT (project_id, product_id, on_hand_qty, last_updated)
            VALUES (@project_id, source.product_id, source.total_qty, GETDATE());

        COMMIT TRANSACTION;
        SELECT @NewTransID AS NewID, N'Nhập kho thành công' AS Message;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;

--======================================PROC USAGE
CREATE PROCEDURE sp_InsertProjectUsage
    @project_id INT,
    @project_code VARCHAR(50),
    @total_quantity DECIMAL(18, 2),
    @reference_no VARCHAR(50),
    @u_for_dep VARCHAR(50),
    @emp_name_get NVARCHAR(100),
    @note NVARCHAR(255),
    @emp_id INT,
    @emp_name NVARCHAR(50),
    @Details udt_ProjectUsageDetail READONLY
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Chèn bảng chính (Usage Transactions)
        DECLARE @NewTransID INT;
        INSERT INTO Project_Usage_Inventory_Transactions 
            (project_id, project_code, total_quantity, reference_no, u_for_dep, emp_name_get, note, emp_id, emp_name)
        VALUES 
            (@project_id, @project_code, @total_quantity, @reference_no, @u_for_dep, @emp_name_get, @note, @emp_id, @emp_name);
        
        SET @NewTransID = SCOPE_IDENTITY();

        -- 2. Chèn bảng chi tiết (Details)
        INSERT INTO Project_Usage_Invetory_Details (p_u_trans_id, product_id, usage_qty, unit, [time], note)
        SELECT @NewTransID, product_id, usage_qty, unit, [time], note FROM @Details;

        -- 3. Cập nhật trừ tồn kho (Project_Stock)
        UPDATE ps
        SET ps.on_hand_qty = ps.on_hand_qty - d.total_qty,
            ps.last_updated = GETDATE()
        FROM Project_Stock ps
        JOIN (SELECT product_id, SUM(usage_qty) as total_qty FROM @Details GROUP BY product_id) d 
        ON ps.product_id = d.product_id
        WHERE ps.project_id = @project_id;

        COMMIT TRANSACTION;
        SELECT @NewTransID AS NewID, N'Xuất kho thành công' AS Message;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;