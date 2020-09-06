% 本脚本用于计算多个地区的省级基因频率
 data_city = [];

pro_id = data_city(:,1);
N = size(data_city,2);
pro_id_u = unique(pro_id);
sample_num = data_city(:,2);
GF_result = zeros(size(pro_id,1),N);
GF_result_u = zeros(size(pro_id_u,1),N);
k = 1;
p = 1;
c = diff(pro_id);
GF_SUM = sample_num.*data_city(:,3:end);

for i = 1:(size(pro_id,1)-1)
    
    if(c(i)==0 && i~=size(pro_id,1)-1)
        continue;
    elseif(i==size(pro_id,1)-1)
        while(k<=i+1)
            GF_result_u(p,3:end) = GF_result_u(p,3:end)+GF_SUM(k,:);
            GF_result_u(p,2) =  GF_result_u(p,2)+sample_num(k);
            k = k+1;
        end
        GF_result_u(p,3:end) = GF_result_u(p,3:end)./ GF_result_u(p,2);
        p = p+1;
    else
        while(k<=i)
            GF_result_u(p,3:end) = GF_result_u(p,3:end)+GF_SUM(k,:);
            GF_result_u(p,2) =  GF_result_u(p,2)+sample_num(k);
            k = k+1;
        end
        GF_result_u(p,3:end) = GF_result_u(p,3:end)./ GF_result_u(p,2);
        p = p+1;
    end
end

    

        