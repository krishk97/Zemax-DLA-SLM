function mystruct= formatBeamData(table_header, table)
% this function takes beam data storted in multi-level cell and stores it
% in a easy to use struct. 

% create struct to contain mutiple surface data
mystruct = struct;

% store data from each colomn into struct
header_num = size(table_header,2); 
for i=1:header_num
    fieldname = table_header{i}{1};
    mystruct.(fieldname)= table{i};
end

end

