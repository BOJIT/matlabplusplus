% FILE:         Config.m
% DESCRIPTION:  Configuration Panel for recalculation
% AUTHOR:       James Bennion-Pedley
% DATE CREATED: 13/09/2022

%------------------------------------------------------------------------------%

classdef Config < handle

    %---------------------------- Public Properties ---------------------------%
    properties
        Callback = @Config.nullCallback;
        Context = struct;
    end

    properties (Dependent)

    end

    %---------------------------- Private Properties --------------------------%
    properties (Access = private)
        Params = cell2table(cell(0, 2), 'VariableNames', {'Param', 'Value'});
        Table;
    end

    properties (Access = private, Dependent)

    end

    %------------------------------- Constructor ------------------------------%
    methods
        function obj = Config(callback)
            f = uifigure('HandleVisibility', 'on');

            obj.Table = uitable(f, 'Data', obj.Params, 'units', 'normalized', 'position', [0, 0, 1, 1]);
            obj.Table.ColumnEditable = [false, true];
            obj.Table.CellEditCallback = @obj.internalCallback;

            if nargin >= 1
                obj.Callback = callback;
            end
        end
    end

    %------------------------------ Public Methods ----------------------------%
    methods
        function add(obj, name, value)
            obj.Params = [obj.Params; cell2table({name, value}, 'VariableNames', {'Param', 'Value'})];

            obj.Table.Data = obj.Params;
        end

        function c = get(obj)
            c = struct;

            for i = 1:height(obj.Table.Data)
                c.(char(obj.Table.Data{i, 1})) = obj.Table.Data{i, 2};
            end
        end
    end

    %------------------------------ Private Methods ---------------------------%

    methods (Access = private)
        function internalCallback(obj, ~, ~)
            obj.Callback(obj.get(), obj.Context);
        end
    end

    methods (Access = private, Static)
        function nullCallback(~)
            % Deliberately empty
        end
    end

    %------------------------------ Get/Set Methods ---------------------------%
    methods

    end

end
