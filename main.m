list = {'Interface Tracking', 'Lagrangian-Eulerian Particle Tracking'};
[mode,tf] = listdlg('PromptString',{'Select run mode',''}, 'SelectionMode', 'single','ListString',list);

switch mode
    case 1
        mainIT()
    case 2
        mainLE()
end
