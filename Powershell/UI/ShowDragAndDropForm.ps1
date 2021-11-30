Add-Type -AssemblyName System.Windows.Forms

# A much better example of using Drag and Drop
# https://www.rlvision.com/blog/a-drag-and-drop-gui-made-with-powershell/

# Create a form

$form = New-Object System.Windows.Forms.Form

$form.AllowDrop = $true;

# Add a label

$label = New-Object Windows.Forms.Label
$label.Location = '5,40'
$label.AutoSize = $True
$label.Text = "Drop files or folders here"

$form.Controls.Add($label)

$form_DragOver = [System.Windows.Forms.DragEventHandler]{
	if ($_.Data.GetDataPresent([Windows.Forms.DataFormats]::FileDrop)) # $_ = [System.Windows.Forms.DragEventArgs]
	{
	    $_.Effect = 'Copy'
	}
	else
	{
	    $_.Effect = 'None'
	}
}

$form_DragDrop = [System.Windows.Forms.DragEventHandler]{
	foreach ($filename in $_.Data.GetData([Windows.Forms.DataFormats]::FileDrop)) # $_ = [System.Windows.Forms.DragEventArgs]
    {
		$label.Text = $fileName
	}
}

$form.Add_DragOver($form_DragOver)
$form.Add_DragDrop($form_DragDrop)

$form.ShowDialog()