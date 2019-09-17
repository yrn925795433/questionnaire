package io.sipai.modules.sys.dao;

        import com.baomidou.mybatisplus.core.metadata.IPage;

import io.sipai.modules.sys.entity.QuestionsEntity;
import io.sipai.modules.sys.entity.UseranswerEntity;
import io.sipai.modules.sys.entity.UserquestionEntity;
import io.sipai.modules.sys.service.QuestionsService;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
        import org.apache.ibatis.annotations.Mapper;
        import org.apache.ibatis.annotations.Param;
import org.hibernate.validator.constraints.ParameterScriptAssert;

import java.util.List;
import java.util.Map;

/**
 * 用户答题
 *
 * @author Leo

 */
@Mapper
public interface UserquestionDao extends BaseMapper<UserquestionEntity> {

	public List<QuestionsEntity> queryList(Map<String, Object> params);
	


}
