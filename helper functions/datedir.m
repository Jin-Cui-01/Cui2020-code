function out = datedir(mouse, date, server)
%DATEDIR Gets the directory of the mouse and date, accounting for 
%   the fact that you may have added extra text

%   Expects pathbase\mousedir\datedir\rundir\files defined in their
%   respective functions
%   mousedir expected to be just the mouse name
%   datedir expected to be [date string]_mouse or [date string]
%   rundir expected to be [date string]_[mouse]_run[run int] or 
%       [date_string]_[mouse]_[3-digit run int]
%   Examples:
%       pathbase\CB173\160519_CB173\160519_CB173_run8\
%       pathbase\CB173\160519\160519_CB173_008\

    if nargin < 3, server = []; end
    
    out = [];
    
    mousedir = pipe.lab.mousedir(mouse, server);
    if isempty(mousedir), return; end
        
    matchstr1 = sprintf('%s_%s', date, mouse);
    matchstr2 = sprintf('%s', date, mouse);
    matchstr3 = sprintf('%s', date);
    matchstr4 = sprintf('20%s', date);

    
    if exist(fullfile(mousedir, matchstr1), 'file') > 0
        out = fullfile(mousedir, matchstr1);
        return
    elseif exist(fullfile(mousedir, matchstr2), 'file') > 0
        out = fullfile(mousedir, matchstr2);
        return
    elseif exist(fullfile(mousedir, matchstr3), 'file') > 0
        out = fullfile(mousedir, matchstr3);
        return
    elseif exist(fullfile(mousedir, matchstr4), 'file') > 0
        out = fullfile(mousedir, matchstr4);
        return
    end
    
    fs = dir(mousedir);
    for i=1:length(fs)
        if fs(i).isdir
            if length(fs(i).name) > length(matchstr1)
                if strcmp(fs(i).name(1:length(matchstr1)), matchstr1)
                    out = fullfile(mousedir, fs(i).name);
                    return
                end
            end
            if length(fs(i).name) > length(matchstr2)
                if strcmp(fs(i).name(1:length(matchstr2)), matchstr2)
                    out = fullfile(mousedir, fs(i).name);
                    return
                end
            end
        end
    end
end

