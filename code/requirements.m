% Requirements
% - up to date version of fieldtrip, later than early 2024
% - EEGLAB with packages 'bids-matlab-tools' and 'bemobil-pipeline'
%   - get bemobil-pipeline from here and select branch 'bemobil_bids':
%     https://github.com/sjeung/bemobil-pipeline

installed_packages = ver();

if ~contains({installed_packages.Name}, 'FieldTrip')
    error('FieldTrip not installed, install an up-to-date Version')
end

if ~contains({installed_packages.Name}, 'EEGLAB')
    error('EEGLAB not installed, install an up-to-date Version')
end

if ~contains(path(), 'bemobil-pipeline')
    error('bemobil-pipeline not in path')
end

if ~contains(path(), 'bids-matlab-tools')
    error('bemobil-pipeline not in path')
end