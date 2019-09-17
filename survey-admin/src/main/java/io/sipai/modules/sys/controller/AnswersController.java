package io.sipai.modules.sys.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import io.sipai.common.validator.ValidatorUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import io.sipai.modules.sys.entity.AnswersEntity;
import io.sipai.modules.sys.entity.QuestionsEntity;
import io.sipai.modules.sys.entity.TestsEntity;
import io.sipai.modules.sys.entity.TestsNameEntity;
import io.sipai.modules.sys.service.AnswersService;
import io.sipai.modules.sys.service.QuestionsService;
import io.sipai.modules.sys.service.TestsNameService;
import io.sipai.modules.sys.service.TestsService;
import io.sipai.common.annotation.SysLog;
import io.sipai.common.utils.PageUtils;
import io.sipai.common.utils.R;



/**
 * 答题管理
 *
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2019-05-29 16:27:20
 */
@RestController
@RequestMapping("sys/answers")
public class AnswersController {
    @Autowired
    private AnswersService answersService;
    @Autowired 
    private TestsService testsService;
    @Autowired
    private QuestionsService questionsService;
    @Autowired
    private TestsNameService testsNameService;
    

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("sys:answers:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = answersService.queryPage(params);

        return R.ok().put("page", page);
    }
    
    @RequestMapping("/addTests")
    @RequiresPermissions("sys:answers:addTests")
    public R addTests(@RequestParam Map<String, Object> params){
    	
    	String testsName = (String) params.get("testsName");
    	
    	TestsNameEntity testsNameEntity = new TestsNameEntity();
    	testsNameEntity.setTestsName(testsName);
    	testsNameService.save(testsNameEntity);
    	return R.ok();
    }

    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("sys:answers:info")
    public R info(@PathVariable("id") Long id){
        AnswersEntity answers = answersService.getById(id);
        
        QueryWrapper<TestsNameEntity> firstQueryWrapper = new QueryWrapper<>();
        firstQueryWrapper.eq("tests_id", answers.getTestsId());
        TestsNameEntity testsNameEntity = testsNameService.getOne(firstQueryWrapper);
        
        if (testsNameEntity != null) {
        answers.setTestsName(testsNameEntity.getTestsName());
        }
        
        QueryWrapper<QuestionsEntity> secondQueryWrapper = new QueryWrapper<>();
        secondQueryWrapper.eq("questions_id", answers.getQuestionsId());
        QuestionsEntity questionsEntity = questionsService.getOne(secondQueryWrapper);
        
        if (questionsEntity != null) {
        	answers.setQuestion(questionsEntity.getQuestion());
        }
        
        return R.ok().put("answers", answers);
    }

    /**
     * 保存
     */
	@SysLog("保存测试")
    @RequestMapping("/save")
    @RequiresPermissions("sys:answers:save")
    public R save(@RequestBody AnswersEntity answers){
    	if (answers.getQuestion() == null) {
        	TestsNameEntity testsNameEntity = new TestsNameEntity();
        	testsNameEntity.setTestsName(answers.getTestsName());
        	testsNameService.save(testsNameEntity);
        	return R.ok();
    	}
    	else {
        QueryWrapper<TestsNameEntity> firstQueryWrapper = new QueryWrapper<>();
        firstQueryWrapper.eq("tests_name", answers.getTestsName());
        TestsNameEntity testsNameEntity = testsNameService.getOne(firstQueryWrapper);
        if (testsNameEntity != null) {
        	answers.setTestsId(testsNameEntity.getTestsId());
        }
        
        QueryWrapper<QuestionsEntity> secondQueryWrapper = new QueryWrapper<>();
        secondQueryWrapper.eq("question", answers.getQuestion());
        QuestionsEntity questionsEntity = questionsService.getOne(secondQueryWrapper);
        if(questionsEntity != null) {
        	answers.setQuestionsId(questionsEntity.getQuestionsId());
        }
        
        answersService.save(answers);

        return R.ok();
    	}
    }

    /**
     * 修改
     */
	@SysLog("修改测试")
    @RequestMapping("/update")
    @RequiresPermissions("sys:answers:update")
    public R update(@RequestBody AnswersEntity answers){
        
        QueryWrapper<TestsNameEntity> firstQueryWrapper = new QueryWrapper<>();
        firstQueryWrapper.eq("tests_name", answers.getTestsName());
        TestsNameEntity testsNameEntity = testsNameService.getOne(firstQueryWrapper);
        if (testsNameEntity != null) {
        	answers.setTestsId(testsNameEntity.getTestsId());
        }
        
        QueryWrapper<QuestionsEntity> secondQueryWrapper = new QueryWrapper<>();
        secondQueryWrapper.eq("question", answers.getQuestion());
        QuestionsEntity questionsEntity = questionsService.getOne(secondQueryWrapper);
        if(questionsEntity != null) {
        	answers.setQuestionsId(questionsEntity.getQuestionsId());
        }
        
        ValidatorUtils.validateEntity(answers);
        answersService.updateById(answers);
        
        return R.ok();
    }

    /**
     * 删除
     */
	@SysLog("删除测试")
    @RequestMapping("/delete")
    @RequiresPermissions("sys:answers:delete")
    public R delete(@RequestBody Long[] answersIds){
        answersService.removeByIds(Arrays.asList(answersIds));

        return R.ok();
    }
    
    @RequestMapping("/questionList/{testsId}")
    public R questionList(@PathVariable("testsId") Long testsId){
        
        QueryWrapper<AnswersEntity> firstQueryWrapper = new QueryWrapper<>();
        firstQueryWrapper.eq("tests_id", testsId);
        List<AnswersEntity> questionList = answersService.list(firstQueryWrapper);
        
        for (AnswersEntity question : questionList) {
        	question.setQuestion(questionsService.getById(question.getQuestionsId()).getQuestion());
        }   
        return R.ok().put("answers", questionList);
    }
}
