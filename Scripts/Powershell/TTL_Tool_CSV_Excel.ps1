Param( 
  $csvFile = "C:\Users\james.clair\Desktop\test.csv", 
  $path = "C:\Users\james.clair\Desktop\test.xlsx" 
) 
$DiskUsage = Import-Csv -Path $csvFile 
$Excel = New-Object -ComObject excel.application 
$Excel.visible = $True 
$workbook = $Excel.workbooks.add() 
$excel.cells.item(1,1) = "Server Name" 
$excel.cells.item(1,2) = "index_name" 
$excel.cells.item(1,3) = "partition_number" 
$excel.cells.item(1,4) = "total_used_pages" 
$excel.cells.item(1,5) = "row_count" 
$i = 2
foreach($column in $DiskUsage | where-object ($column.index_name = "Msg_PK"))
{ 
 $excel.cells.item($i,1) = $column.'Server Name'
 $excel.cells.item($i,2) = $column.index_name
 $excel.cells.item($i,3) = $column.partition_number
 $excel.cells.item($i,4) = $column.total_used_pages
 $excel.cells.item($i,5) = $column.row_count
 $i++ 
}

$workbook.saveas($path)
$i=2
do 
{
    if ($Excel.Cells($i, 8).Value -ne "Msg_PK")
    {
    Then
        Set Range = $Excel.Cells($i, 8).EntireRow
        Range.Delete
        $i=$i -1
    End If
    $i = $i + 1
    }
Loop
} until ($Excel.cells($i, 8).Value = "")

