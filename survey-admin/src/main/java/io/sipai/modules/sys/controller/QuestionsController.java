package io.sipai.modules.sys.controller;

import java.util.Arrays;
import java.util.HashMap;
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

import io.sipai.modules.sys.entity.QuestionsEntity;
import io.sipai.modules.sys.entity.SysDeptEntity;
import io.sipai.modules.sys.entity.SysRoleEntity;
import io.sipai.modules.sys.entity.TestsEntity;
import io.sipai.modules.sys.service.QuestionsService;
import io.sipai.common.annotation.SysLog;
import io.sipai.common.utils.Constant;
import io.sipai.common.utils.PageUtils;
import io.sipai.common.utils.R;



/**
 * 题库管理
 *
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2019-05-29 16:27:20
 */
@RestController
@RequestMapping("sys/questions")
public class QuestionsController {
    @Autowired
    private QuestionsService questionsService;
    

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("sys:questions:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = questionsService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{questionsId}")
    @RequiresPermissions("sys:questions:info")
    public R info(@PathVariable("questionsId") Long questionsId){
        QuestionsEntity questions = questionsService.getById(questionsId);

        return R.ok().put("questions", questions);
    }

    /**
     * 保存
     */
	@SysLog("保存题目")
    @RequestMapping("/save")
    @RequiresPermissions("sys:questions:save")
    public R save(@RequestBody QuestionsEntity questions){
        questionsService.save(questions);
        
        return R.ok();
    }
    @RequestMapping("/select")
    @RequiresPermissions("sys:questions:select")
    public R select(){
		List<QuestionsEntity> questionList = questionsService.queryList(new HashMap<String, Object>());
        return R.ok().put("questionList", questionList);
    }
    
    

    /**
     * 修改
     */
	@SysLog("修改题目")
    @RequestMapping("/update")
    @RequiresPermissions("sys:questions:update")
    public R update(@RequestBody QuestionsEntity questions){
        ValidatorUtils.validateEntity(questions);
        questionsService.updateById(questions);
        
        return R.ok();
    }

    /**
     * 删除
     */
	@SysLog("删除题目")
    @RequestMapping("/delete")
    @RequiresPermissions("sys:questions:delete")
    public R delete(@RequestBody Long[] questionsIds){
        questionsService.removeByIds(Arrays.asList(questionsIds));

        return R.ok();
    }
    
    @RequestMapping("/selectAll")
    @RequiresPermissions("sys:questions:selectAll")
    public R selectAllQuestion(@RequestParam Map<String, Object> params){
        PageUtils page = questionsService.queryAllQuestions(params);
        return R.ok().put("page", page);
    }
    
	@RequestMapping("/selectByGrade")
    @RequiresPermissions("sys:questions:selectByGrade")
	public R selectByGrade(){
		List<QuestionsEntity> questionsListByGrade = questionsService.queryListByGrade(new HashMap<String, Object>());
		return R.ok().put("questionsListByGrade", questionsListByGrade);
	}
    
    

}
