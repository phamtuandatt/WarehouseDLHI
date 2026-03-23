CREATE TRIGGER trg_UpdateProjectStock
ON Project_Inventory_Transactions
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Duyệt qua từng dòng dữ liệu mới chèn vào (inserted)
    MERGE Project_Stock AS target
    USING (SELECT project_id, product_id, 
                  SUM(CASE WHEN trans_type = 'PROJECT_IMPORT' THEN quantity 
                           WHEN trans_type = 'PROJECT_USAGE' THEN -quantity ELSE 0 END) as ChangeQty
           FROM inserted
           GROUP BY project_id, material_id) AS source
    ON (target.project_id = source.project_id AND target.product_id	= source.product_id)
    
    -- Nếu đã có vật tư này trong kho dự án: Cập nhật cộng dồn
    WHEN MATCHED THEN
        UPDATE SET target.on_hand_qty = target.on_hand_qty + source.ChangeQty,
                   target.last_updated = GETDATE()
    
    -- Nếu chưa có (vật tư mới nhập lần đầu cho dự án): Tạo dòng mới
    WHEN NOT MATCHED THEN
        INSERT (project_id, product_id, on_hand_qty, last_updated)
        VALUES (source.project_id, source.product_id, source.ChangeQty, GETDATE());
END
GO

--CREATE TRIGGER trg_MPR_Details_Audit
--ON MPR_Details
--AFTER UPDATE, DELETE
--AS
--BEGIN
--    SET NOCOUNT ON;

--    -- 1. Trường hợp UPDATE: Ghi lại thay đổi số lượng vật tư
--    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
--    BEGIN
--        INSERT INTO MPR_Audit_Log (mpr_id, table_name, column_name, old_value, new_value, action_type, changed_by_emp_id)
--        SELECT 
--            i.mpr_id, 
--            'MPR_Details', 
--            N'Số lượng (material_id: ' + CAST(i.material_id AS VARCHAR) + ')', 
--            CAST(d.requested_qty AS NVARCHAR(MAX)), 
--            CAST(i.requested_qty AS NVARCHAR(MAX)), 
--            'UPDATE',
--            (SELECT requester_id FROM MPR_Header WHERE mpr_id = i.mpr_id)
--        FROM inserted i
--        JOIN deleted d ON i.mpr_detail_id = d.mpr_detail_id
--        WHERE i.requested_qty <> d.requested_qty;
--    END

--    -- 2. Trường hợp DELETE: Ghi lại khi một dòng vật tư bị xóa khỏi phiếu
--    IF NOT EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
--    BEGIN
--        INSERT INTO MPR_Audit_Log (mpr_id, table_name, column_name, old_value, new_value, action_type, changed_by_emp_id)
--        SELECT 
--            d.mpr_id, 
--            'MPR_Details', 
--            N'Xóa dòng vật tư', 
--            N'Mã vật tư ID: ' + CAST(d.product_id AS VARCHAR), 
--            NULL, 
--            'DELETE',
--            (SELECT requester_id FROM MPR_Header WHERE mpr_id = d.mpr_id)
--        FROM deleted d;
--    END
--END
--GO