param(
    [Parameter()]
    [string]$PROGRAM_JSON_DIR = "."
)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

#Load Config JSON
$config = Get-Content $PROGRAM_JSON_DIR\Programs.json | ConvertFrom-Json

# Create Form and label
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Start Programs'
$form.Size = New-Object System.Drawing.Size(450,300)
$form.StartPosition = 'CenterScreen'
$form.Topmost = $true

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(400,30)
$label.Text = 'Please make a selection from the list below:'
$form.Controls.Add($label)

#
#
#  Create Checkboxes for each program in the config
#
#
#
$buttonSize = New-Object System.Drawing.Size(100, 40)
$pos = 0
$rowNum = 0

#Array to hold the check boxes
$checkBoxes = @()

foreach($program in $config.Programs){
    #Calculate where to place the button
    $x = 10 + $buttonSize.Width * ($pos % 4);
    $rowNum = [Math]::Floor($pos/4)
    $y = 50 + ($buttonSize.Height * $rowNum);
    $checkBox = New-Object System.Windows.Forms.checkBox
    $checkBox.Appearance = [System.Windows.Forms.Appearance]::Button
    $checkBox.Size = $buttonSize
    $checkBox.Text = $program.Title
    $checkBox.Location = New-Object System.Drawing.Point($x, $y)
    $checkBox.Checked = $program.IsSelected
    $form.Controls.Add($checkBox)
    $checkBoxes += ,$checkBox
    $pos = $pos + 1
}

#OK and Cancel Buttons
$x = 10 + $buttonSize.Width;
$y = 60 + ($buttonSize.Height * ($rowNum + 1))
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point($x,$y)
$OKButton.Size = $buttonSize
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(($x + $buttonSize.Width), $y)
$CancelButton.Size = $buttonSize
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$result = $form.ShowDialog()

#Collect the selection of programs
if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $i = 0;
    do{
        $box = $checkBoxes[$i];
        if($box.Checked){
            $path = $config.Programs[$i].FilePath;
            $args = $config.Programs[$i].ArgumentList 
            if($args -eq "" -or $args -eq $null){
                Start-Process -FilePath $path
            }else{                    
                Start-Process -FilePath $path -ArgumentList $args
            }
        }
        $i += 1
    }while($i -lt $checkBoxes.Length)
}