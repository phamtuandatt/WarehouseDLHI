
-- Proc export products
CREATE PROCEDURE sp_ExportProjectMaterial
    @ProjectID		INT,
    @ProductID		INT,
    @QtyToExport	DECIMAL(18, 2),
    @EmpID			INT,			-- Người yêu cầu xuất (Module HRM)
	@EmpName		NVARCHAR(50),
    @ReferenceNo	VARCHAR(50),	-- Số lệnh sản xuất hoặc phiếu xuất
    @Note			NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @CurrentStock DECIMAL(18, 2);

    -- 1. Lấy số lượng tồn hiện tại của vật tư trong dự án đó
    SELECT @CurrentStock = on_hand_qty 
    FROM Project_Stock 
    WHERE project_id = @ProjectID AND product_id = @ProductID;

    -- 2. Kiểm tra điều kiện xuất
    IF @CurrentStock IS NULL
    BEGIN
        RAISERROR(N'Error: This product is not available in the project !', 16, 1);
        RETURN;
    END

    IF @CurrentStock < @QtyToExport
    BEGIN
        DECLARE @ErrMsg NVARCHAR(250) = N'Error: This product is currently out of stock! (Available: ' 
                                        + CAST(@CurrentStock AS NVARCHAR) + N', Requiment: ' 
                                        + CAST(@QtyToExport AS NVARCHAR) + N')';
        RAISERROR(@ErrMsg, 16, 1);
        RETURN;
    END

    -- 3. Nếu đủ điều kiện, tiến hành ghi log giao dịch
    -- Trigger trg_UpdateProjectStock (đã tạo ở bước trước) sẽ tự động trừ Project_Stock.on_hand_qty
    INSERT INTO Project_Inventory_Transactions (
        project_id, product_id, trans_type, quantity, reference_no, note, emp_id, emp_name, trans_date
    )
    VALUES (
        @ProjectID, @ProductID, 'PROJECT_USAGE', @QtyToExport, @ReferenceNo, @Note, @EmpID, @EmpName, GETDATE()
    );

    SELECT N'Successfully shipped from the warehouse!' AS Result;
END
GO
-- proc import material
CREATE PROCEDURE sp_ImportProjectStock
    @ProjectID		INT,
    @ProductID		INT,
    @QtyToImport	DECIMAL(18, 2),
    @EmpID			INT,           -- Người thực hiện nhập (Module HRM)
	@EmpName		NVARCHAR(50),
    @ReferenceNo	VARCHAR(50), -- Số phiếu PO hoặc số vận đơn
    @Note			NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Ghi log giao dịch nhập kho
        -- Trigger trg_UpdateProjectStock sẽ tự động cộng dồn vào bảng Project_Stock
        INSERT INTO Project_Inventory_Transactions (
            project_id, product_id, trans_type, quantity, reference_no, note, emp_id, emp_name, trans_date
        )
        VALUES (
            @ProjectID, @ProductID, 'PROJECT_IMPORT', @QtyToImport, @ReferenceNo, @Note, @EmpID, @EmpName, GETDATE()
        );

        COMMIT TRANSACTION;
        SELECT N'Successfully received into inventory!' AS Result;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
    END CATCH
END
GO