%% 并行测试第一轮，先用范例测试GPU是否正常工作

function [y] = cuda_1(x,n)
y = 0;
if n ==1
    
    y = zeros(size(x));
    for i = 1:size(x,1)
        for j = 1:size(x,2)
            y(i,j)=(x(i,j)^2)/(i+j);
        end
    end
elseif n==2
    
    y = coder.nullcopy(zeros(size(x)));
    coder.gpu.kernel();
    for i = 1:size(x,1)
        for j = 1:size(x,2)
            y(i,j)=(x(i,j)^2)/(i+j);
        end
    end
end
end

