CREATE TRIGGER trg_MPR_Details_Audit
ON MPR_Details
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Trường hợp UPDATE: Ghi lại thay đổi số lượng vật tư
    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO MPR_Audit_Log (mpr_id, table_name, column_name, old_value, new_value, action_type, changed_by_emp_id)
        SELECT 
            i.mpr_id, 
            'MPR_Details', 
            N'Số lượng (material_id: ' + CAST(i.material_id AS VARCHAR) + ')', 
            CAST(d.requested_qty AS NVARCHAR(MAX)), 
            CAST(i.requested_qty AS NVARCHAR(MAX)), 
            'UPDATE',
            (SELECT requester_id FROM MPR_Header WHERE mpr_id = i.mpr_id)
        FROM inserted i
        JOIN deleted d ON i.mpr_detail_id = d.mpr_detail_id
        WHERE i.requested_qty <> d.requested_qty;
    END

    -- 2. Trường hợp DELETE: Ghi lại khi một dòng vật tư bị xóa khỏi phiếu
    IF NOT EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO MPR_Audit_Log (mpr_id, table_name, column_name, old_value, new_value, action_type, changed_by_emp_id)
        SELECT 
            d.mpr_id, 
            'MPR_Details', 
            N'Xóa dòng vật tư', 
            N'Mã vật tư ID: ' + CAST(d.product_id AS VARCHAR), 
            NULL, 
            'DELETE',
            (SELECT requester_id FROM MPR_Header WHERE mpr_id = d.mpr_id)
        FROM deleted d;
    END
END
GO