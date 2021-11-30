Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Topmost = $true
$form.ControlBox = $false
$form.Text = ""

$panel = New-Object System.Windows.Forms.Panel
$panel.BackColor = [System.Drawing.Color]::White
$panel.Padding = New-Object System.Windows.Forms.Padding 15
$panel.Dock = [System.Windows.Forms.DockStyle]::Fill

$richTextBox = New-Object System.Windows.Forms.RichTextBox
$richTextBox.BorderStyle = [System.Windows.Forms.BorderStyle]::None
$richTextBox.Dock = [System.Windows.Forms.DockStyle]::Fill

$panel.controls.add($richTextBox)
$form.controls.add($panel)

$richTextBox.Rtf = "{\rtf1\ansi
\fs24
Welcome to \b Presenter\b0.\line\line
It's aim is to help on screen demonstrations by having a docked agenda on the side.\line\line
}"

$form.ShowDialog()