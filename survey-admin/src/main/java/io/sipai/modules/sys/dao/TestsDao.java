package io.sipai.modules.sys.dao;

import io.sipai.modules.sys.entity.TestsEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 测试管理
 * 
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2019-05-29 16:27:20
 */
@Mapper
public interface TestsDao extends BaseMapper<TestsEntity> {
	
}
