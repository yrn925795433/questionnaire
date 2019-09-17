package io.sipai.modules.user.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import io.sipai.modules.user.entity.TestsEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 测试管理
 * @date 2019-05-29 16:27:20
 */
@Mapper
public interface TestsDao extends BaseMapper<TestsEntity> {
	
}
