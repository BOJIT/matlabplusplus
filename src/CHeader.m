% FILE:         CHeader.m
% DESCRIPTION:  Tool for generating C header files programatically
% AUTHOR:       James Bennion-Pedley
% DATE CREATED: 28/06/2022

%------------------------------------------------------------------------------%

classdef CHeader < handle

    %---------------------------- Public Properties ---------------------------%
    properties
        Author = "James Bennion-Pedley";
        Copyright = "James Bennion-Pedley";
        Date;
    end

    properties (Dependent)

    end

    %---------------------------- Private Properties --------------------------%
    properties (Access = private)
        FilePath = '';
        MName = '';
        Tokens = {};
    end

    properties (Access = private, Dependent)

    end

    %------------------------------- Constructor ------------------------------%
    methods
        function obj = CHeader(filepath, mname)
            obj.FilePath = filepath;
            obj.MName = strcat(mname, ".m");
            obj.Date = date;
        end
    end

    %------------------------------ Public Methods ----------------------------%
    methods
        function generate(obj)
            % Generate Header File
            fid = fopen(obj.FilePath, 'w+');
            fwrite(fid, obj.generateFileHeader());

            for T = obj.Tokens
                fwrite(fid, T{:});
            end

            fwrite(fid, obj.generateFileFooter());
            fclose(fid);
        end

        function addMacro(obj, name, val)
            if ~(ischar(val) || isstring(val))
                val = num2str(val);
            end

            stub = sprintf('#define %s %s;\n\n', name, val);
            obj.Tokens = [obj.Tokens, {stub}];
        end

        function addMatrix(obj, name, val, type)
            stub = sprintf('static %s %s', type, name);

            % Reverse dimension order to be more 'intuitive'
            val = permute(val, flip(1:ndims(val)));

            % Get dimensions of target array
            n = size(val);
            n(n == 1) = [];
            for i = 1:length(n)
                stub = sprintf('%s[%u]', stub, n(length(n) - i + 1));
            end

            % Generate C array
            stub = sprintf('%s = %s;\n\n', stub, obj.validCArray(val));

            obj.Tokens = [obj.Tokens, {stub}];
        end
    end

    %------------------------------ Private Methods ---------------------------%
    methods
        function h = generateFileHeader(obj)
            mac = obj.validCMacro(obj.FilePath);
            h = sprintf(strcat( ...
            "/**\n", ...
            " * @file %s\n", ...
            " * @author %s\n", ...
            " * @brief THIS HEADER IS AUTO-GENERATED FROM %s\n", ...
            " * @date %s\n", ...
            " *\n", ...
            " * @copyright Copyright (c) %s 2022\n", ...
            " *\n", ...
            " */\n\n", ...
            "#ifndef __%s__\n", ...
            "#define __%s__\n\n", ...
            "/*----------------------------------------------------------------------------*/\n\n", ...
            "#include <stddef.h>\n", ...
            "#include <stdint.h>\n\n"), ...
            obj.FilePath, obj.Author, obj.MName, obj.Date, obj.Copyright, mac, mac);
        end

        function f = generateFileFooter(obj)
            f = sprintf(strcat( ...
            "/*----------------------------------------------------------------------------*/\n", ...
            "\n", ...
            "#endif /* __%s__ */\n"), ...
            obj.validCMacro(obj.FilePath));
        end

        function out = validCMacro(~, in)
            str = upper(in);
            out = regexprep(str,'[-.]','_');
        end

        function str = validCArray(obj, m, depth)
            % Get dimensions of target array
            n = size(m);
            n(n == 1) = [];
            dims = length(n);

            if(nargin >= 3)
                depth = depth + 1;
                indent = repmat('    ', 1, depth);
            else
                depth = 0;
                indent = '';
            end

            str = '';

            if(dims == 1)
                expr = '';
                if depth == 0
                    % Exception for 1D arrays
                    expr = sprintf('%s\n', expr);
                    for i = 1:length(m)
                        expr = sprintf('%s    %s,\n', expr, num2str(m(i)));
                    end
                    expr = expr(1:end - 2);
                    expr = sprintf('%s\n', expr);
                else
                    for i = 1:length(m)
                        expr = sprintf('%s%s, ', expr, num2str(m(i)));
                    end
                    expr = expr(1:end - 2);
                end
                expr = sprintf('%s{%s}', indent, expr);
                str = strcat(str, expr);
            else
                expr = '';
                for i = 1:size(m, dims)
                    C = repmat({':'}, 1, dims);
                    C{end} = i;

                    expr = sprintf('%s%s,\n', expr, obj.validCArray(squeeze(m(C{:})), depth));
                end
                expr = expr(1:end - 2);
                expr = sprintf('%s{\n%s\n%s}', indent, expr, indent);
                str = strcat(str, expr);
            end
        end
    end

    %------------------------------ Get/Set Methods ---------------------------%
    methods

    end

end
