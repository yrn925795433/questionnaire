package io.sipai.modules.sys.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.injector.methods.SelectById;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import io.sipai.common.utils.PageUtils;
import io.sipai.common.utils.Query;

import io.sipai.modules.sys.dao.QuestionsDao;
import io.sipai.modules.sys.entity.QuestionsEntity;
import io.sipai.modules.sys.entity.SysRoleDeptEntity;
import io.sipai.modules.sys.entity.TestsEntity;
import io.sipai.modules.sys.entity.UserquestionEntity;
import io.sipai.modules.sys.service.QuestionsService;


@Service("questionsService")
public class QuestionsServiceImpl extends ServiceImpl<QuestionsDao, QuestionsEntity> implements QuestionsService {
	
	@Autowired
	private QuestionsService questionsService;
	
	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<QuestionsEntity> page = this.page(
                new Query<QuestionsEntity>().getPage(params),
                new QueryWrapper<QuestionsEntity>().gt("questions_id", 0)
        );

        return new PageUtils(page);
    }


	@Override
	public void saveOrUpdate(Long questionsId,String question, String option1, String option2, String option3,String option4) {
			
		    QuestionsEntity questionsEntity = getById(questionsId);
		    if (questionsEntity == null) {
		    questionsEntity = new QuestionsEntity();
		    }
			questionsEntity.setQuestion(question);
			questionsEntity.setOption1(option1);
			questionsEntity.setOption2(option2);
			questionsEntity.setOption3(option3);
			questionsEntity.setOption4(option4);
		    
			this.updateById(questionsEntity);
		}
	
	
	@Override
	public int deleteBatch(Long[] questionsIds) {
		return baseMapper.deleteBatch(questionsIds);
	}



	@Override
	public QuestionsEntity queryQuestion(Long questionsId) {
		return baseMapper.queryQuestion(questionsId);
	}

	@Override
	public List<Long> queryQuestionIdList(Long id) {
		return baseMapper.queryQuestionIdList(id);
	}


	@Override
	public List<QuestionsEntity> queryList(Map<String, Object> map) {
		return baseMapper.queryList(map);
	}


	@Override
	public PageUtils queryAllQuestions(Map<String, Object> params) {
		
				IPage<QuestionsEntity> page = this.page(
						new Query<QuestionsEntity>().getPage(params),
						new QueryWrapper<QuestionsEntity>().gt("questions_id", 0).orderByAsc("questions_id")
					);

		        return new PageUtils(page);

	}
	
	@Override
	public List<QuestionsEntity> queryListByGrade(Map<String, Object> params) {
		QueryWrapper<QuestionsEntity> queryWrapper = new QueryWrapper<>();
		queryWrapper.groupBy("grade").isNotNull("grade");
		return questionsService.list(queryWrapper);
	}
	}
	
	


