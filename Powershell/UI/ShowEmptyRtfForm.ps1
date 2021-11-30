Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Topmost = $true

$panel = New-Object System.Windows.Forms.Panel
$panel.BackColor = [System.Drawing.Color]::White
$panel.Padding = New-Object System.Windows.Forms.Padding 5
$panel.Dock = [System.Windows.Forms.DockStyle]::Fill

$richTextBox = New-Object System.Windows.Forms.RichTextBox
$richTextBox.BorderStyle = [System.Windows.Forms.BorderStyle]::None
$richTextBox.Dock = [System.Windows.Forms.DockStyle]::Fill

$panel.controls.add($richTextBox);
$form.controls.add($panel);

$form.ShowDialog()