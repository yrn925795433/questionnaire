package io.sipai.modules.user.controller;

import io.sipai.common.utils.PageUtils;
import io.sipai.common.utils.R;
import io.sipai.common.validator.ValidatorUtils;
import io.sipai.modules.user.entity.AnswersEntity;
import io.sipai.modules.user.service.AnswersService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


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

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("sys:answers:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = answersService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{answersId}")
    @RequiresPermissions("sys:answers:info")
    public R info(@PathVariable("answersId") Long answersId){
        AnswersEntity answers = answersService.getById(answersId);

        return R.ok().put("answers", answers);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("sys:answers:save")
    public R save(@RequestBody AnswersEntity answers){
        answersService.save(answers);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("sys:answers:update")
    public R update(@RequestBody AnswersEntity answers){
        ValidatorUtils.validateEntity(answers);
        answersService.updateById(answers);
        
        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("sys:answers:delete")
    public R delete(@RequestBody Long[] answersIds){
        answersService.removeByIds(Arrays.asList(answersIds));

        return R.ok();
    }
    /**
     * 获取指定用户的题目
     */
    @RequestMapping("/getQuestionsByUserId")
    public R getQuestionsByUserId(@RequestParam Long userId){
        Map<String,Object> map= new HashMap<>();
        map.put("userId",userId);
        List<Map<String,Object>> result = answersService.getQuestionsByUserId(map);
        return R.ok().put("list", result);
    }

    /**
     * 用户提交答案
     */
    @RequestMapping("/submitAnswers")
    public R submitAnswers(@RequestBody Map<String,Object> params){
        boolean result = answersService.submitAnswers((List<Map<String,Object>>)params.get("answers"));
        return R.ok();
    }

}
