package io.sipai.modules.user.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import io.sipai.modules.user.entity.QuestionsEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 题库管理
 * 
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2019-05-29 16:27:20
 */
@Mapper
public interface QuestionsDao extends BaseMapper<QuestionsEntity> {
	
}
