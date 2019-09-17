package io.sipai.modules.sys.controller;

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
import io.sipai.modules.sys.entity.SysUserEntity;
import io.sipai.modules.sys.entity.TestsEntity;
import io.sipai.modules.sys.entity.UseranswerEntity;
import io.sipai.modules.sys.service.QuestionsService;
import io.sipai.modules.sys.service.SysUserService;
import io.sipai.modules.sys.service.TestsService;
import io.sipai.modules.sys.service.UseranswerService;
import io.sipai.common.annotation.SysLog;
import io.sipai.common.utils.PageUtils;
import io.sipai.common.utils.R;



/**
 * 用户答题
 *
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2019-05-29 16:27:20
 */
@RestController
@RequestMapping("sys/useranswer")
public class UseranswerController {
    @Autowired
    private UseranswerService useranswerService;
    
    @Autowired
    private QuestionsService questionsService;
    
    @Autowired
    private TestsService testsService;
    
    @Autowired
    private SysUserService sysUserService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("sys:useranswer:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = useranswerService.queryPage(params);
        return R.ok().put("page", page);
    }
    



    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("sys:useranswer:info")
    public R info(@PathVariable("id") Long id){
    	
        UseranswerEntity useranswer = useranswerService.getById(id);
		TestsEntity testsEntity = testsService.getById(useranswer.getUsertestsId());
		if(testsEntity != null) {
			SysUserEntity sysUserEntity = sysUserService.getById(testsEntity.getUserId());
			if (sysUserEntity != null) {
				useranswer.setUsername(sysUserEntity.getUsername());
			}
		}
		QuestionsEntity question = questionsService.getById(useranswer.getQuestionsId());
		if (question != null) {
			useranswer.setQuestion(question.getQuestion());
		}

        return R.ok().put("useranswer", useranswer);
    }

    /**
     * 保存
     */
	@SysLog("保存用户答题")
    @RequestMapping("/save")
    @RequiresPermissions("sys:useranswer:save")
    public R save(@RequestBody UseranswerEntity useranswer){
    	
        return R.ok();
    }

    /**
     * 修改
     */
	@SysLog("修改用户答题")
    @RequestMapping("/update")
    @RequiresPermissions("sys:useranswer:update")
    public R update(@RequestBody UseranswerEntity useranswer){
    	
        return R.ok();
    }

    /**
     * 删除
     */
	@SysLog("删除用户答题")
    @RequestMapping("/delete")
    @RequiresPermissions("sys:useranswer:delete")
    public R delete(@RequestBody Long[] answersIds){
        useranswerService.deleteBatch(answersIds);

        return R.ok();
    }

}
