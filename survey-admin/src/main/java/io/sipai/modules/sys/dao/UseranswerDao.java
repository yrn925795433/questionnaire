package io.sipai.modules.sys.dao;

        import com.baomidou.mybatisplus.core.metadata.IPage;
        import io.sipai.modules.sys.entity.UseranswerEntity;
        import com.baomidou.mybatisplus.core.mapper.BaseMapper;
        import org.apache.ibatis.annotations.Mapper;
        import org.apache.ibatis.annotations.Param;

        import java.util.Map;

/**
 * 用户答题
 *
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2019-05-29 16:27:20
 */
@Mapper
public interface UseranswerDao extends BaseMapper<UseranswerEntity> {
    //    IPage<Map<String, Object>> useranswerQuery(IPage<UseranswerEntity> page, Map<String, Object> params);
	
	
	
}
